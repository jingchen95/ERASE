/* assembly_sched.cxx -- integrated work stealing with assembly scheduling */
#include "tao.h"
#include <iostream>
#include <numeric>
#include <chrono>
#include <cmath>
#include <algorithm>
#include <vector>
#include <fstream>
#include <mutex>
#include <condition_variable>
#include <atomic>
#include <time.h>
#include <sstream>
#include <cstring>
#include <unistd.h> 
#include <stdint.h>
#include <inttypes.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
#include "xitao_workspace.h"
using namespace xitao;

const int EAS_PTT_TRAIN = 2;

#ifdef PERF_COUNTERS
struct read_format {
  uint64_t nr;
  struct {
    uint64_t value;
    uint64_t id;
  } values[];
};
#endif
std::ofstream pmc("PMC.txt", std::ios_base::app);
  // pmc.open;
std::ofstream Denver("/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed");
#if defined(Haswell)
int num_sockets;
float power[NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
#endif

int a57_freq;
int denver_freq;

#if (defined DynaDVFS)
// int freq_dec;
// int freq_inc;
// 0 denotes highest frequency, 1 denotes lowest. 
// e.g. in 00, first 0 is denver, second 0 is a57. env= 0*2+0 = 0
int env;
// int dynamic_time_change;
int current_freq;
#endif

#if (defined STEER_TH_ANALYSIS) && ((defined STEER_AVERAGE) || (defined STEER_HIGH) || (defined STEER_LOW))
int cur_freq_index[NUMSOCKETS] = {0,0};
long avail_freq[12] = {2035200, 1881600, 1728000, 1574400, 1420800, 1267200, 1113600, 960000, 806400, 652800, 499200, 345600};
#endif

int status[XITAO_MAXTHREADS];
int status_working[XITAO_MAXTHREADS];
int Sched, Parallelism;
int maySteal_DtoA, maySteal_AtoD;
std::atomic<int> DtoA(0);

// define the topology
int gotao_sys_topo[5] = TOPOLOGY;

#ifdef NUMTASKS
int NUM_WIDTH_TASK[XITAO_MAXTHREADS] = {0};
#endif

#ifdef TX2
#ifdef DVFS
float compute_bound_power[NUMSOCKETS][FREQLEVELS][XITAO_MAXTHREADS] = {0.0};
float memory_bound_power[NUMSOCKETS][FREQLEVELS][XITAO_MAXTHREADS] = {0.0};
float cache_intensive_power[NUMSOCKETS][FREQLEVELS][XITAO_MAXTHREADS] = {0.0};
int PTT_UpdateFlag[FREQLEVELS][XITAO_MAXTHREADS][XITAO_MAXTHREADS] = {0};
#elif (defined DynaDVFS) // Currently only consider 4 combinations: max&max, max&min, min&max, min&min
float compute_bound_power[4][NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
float memory_bound_power[4][NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
float cache_intensive_power[4][NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
#else
float compute_bound_power[NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
float memory_bound_power[NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
float cache_intensive_power[NUMSOCKETS][XITAO_MAXTHREADS] = {0.0};
int PTT_UpdateFlag[XITAO_MAXTHREADS][XITAO_MAXTHREADS] = {0};
#endif
#endif


struct timespec tim, tim2;
cpu_set_t affinity_setup;
int TABLEWIDTH;
int worker_loop(int);

#ifdef PowerProfiling
std::ofstream out("KernelTaskTime.txt");
#endif

#ifdef NUMTASKS_MIX
//std::vector<int> num_task(XITAO_MAXTHREADS * XITAO_MAXTHREADS, 0);
int num_task[XITAO_MAXTHREADS][XITAO_MAXTHREADS * XITAO_MAXTHREADS] = {0};
#endif

int PTT_flag[XITAO_MAXTHREADS][XITAO_MAXTHREADS];
std::chrono::time_point<std::chrono::system_clock> t3;
std::mutex m;
std::condition_variable cv;
bool finish = false;

// std::vector<thread_info> thread_info_vector(XITAO_MAXTHREADS);
//! Allocates/deallocates the XiTAO's runtime resources. The size of the vector is equal to the number of available CPU cores. 
/*!
  \param affinity_control Set the usage per each cpu entry in the cpu_set_t
 */
int set_xitao_mask(cpu_set_t& user_affinity_setup) {
  if(!gotao_initialized) {
    resources_runtime_conrolled = true;                                    // make this true, to refrain from using XITAO_MAXTHREADS anywhere
    int cpu_count = CPU_COUNT(&user_affinity_setup);
    runtime_resource_mapper.resize(cpu_count);
    int j = 0;
    for(int i = 0; i < XITAO_MAXTHREADS; ++i) {
      if(CPU_ISSET(i, &user_affinity_setup)) {
        runtime_resource_mapper[j++] = i;
      }
    }
    if(cpu_count < gotao_nthreads) std::cout << "Warning: only " << cpu_count << " physical cores available, whereas " << gotao_nthreads << " are requested!" << std::endl;      
  } else {
    std::cout << "Warning: unable to set XiTAO affinity. Runtime is already initialized. This call will be ignored" << std::endl;      
  }  
}

void gotao_wait() {
//  gotao_master_waiting = true;
//  master_thread_waiting.notify_one();
//  std::unique_lock<std::mutex> lk(pending_tasks_mutex);
//  while(gotao_pending_tasks) pending_tasks_cond.wait(lk);
////  gotao_master_waiting = false;
//  master_thread_waiting.notify_all();
  while(PolyTask::pending_tasks > 0);
}
//! Initialize the XiTAO Runtime
/*!
  \param nthr is the number of XiTAO threads 
  \param thrb is the logical thread id offset from the physical core mapping
  \param nhwc is the number of hardware contexts
*/ 
int gotao_init_hw( int nthr, int thrb, int nhwc)
{
  gotao_initialized = true;
 	if(nthr>=0) gotao_nthreads = nthr;
  else {
    if(getenv("GOTAO_NTHREADS")) gotao_nthreads = atoi(getenv("GOTAO_NTHREADS"));
    else gotao_nthreads = XITAO_MAXTHREADS;
  }
  if(gotao_nthreads > XITAO_MAXTHREADS) {
    std::cout << "Fatal error: gotao_nthreads is greater than XITAO_MAXTHREADS of " << XITAO_MAXTHREADS << ". Make sure XITAO_MAXTHREADS environment variable is set properly" << std::endl;
    exit(0);
  }

#if defined(TX2)
	if(nhwc>=0){
    a57_freq = nhwc;
  }
  else{
    if(getenv("A57")){
      a57_freq = atoi(getenv("A57"));
    }
    else{
      a57_freq = A57;
    }
  } 

	if(nhwc>=0){
    denver_freq = nhwc;
  }
  else{
    if(getenv("DENVER")){
      denver_freq = atoi(getenv("DENVER"));
    }
    else{
      denver_freq = DENVER;
    }
  }
#endif
  
  // Read Power Profile File, including idle and dynamic power
  std::ifstream infile, infile1, infile2;
#ifdef Haswell  
  // infile.open("/cephyr/users/chjing/Hebbe/EAS_XITAO/PowerProfile/Hebbe_MatMul.txt");
  infile.open("/home/x_jinch/ERASE_TACO/PowerProfile/Tetralith_Compute_Bound.txt");
  std::string token;
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        power[ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile.close();
  //Output the power reading
  for(int ii = 0; ii < 1; ii++){
    for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
      std::cout << power[ii][jj] << "\t";
    }
    std::cout << "\n";
  }
#endif

#if (defined TX2)
#if (defined DVFS)
// Needs to find out the task type ??????
  infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_DVFS_MM");
  if(infile.fail()){
    std::cout << "Failed to open power profile file!" << std::endl;
    std::cin.get();
    return 0;
  }
  std::string token;
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    int freq = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        freq = stoi(token);
      }else{
        if(ii == 1){
          pwidth = stoi(token);
        }
        else{
          get_power = stof(token);
          compute_bound_power[freq][ii-2][pwidth] = get_power; 
        } 
      }
      ii++;
      //std::cout << "Token :" << token << std::endl;
    }
    // if(infile.unget().get() == '\n') {
    //   std::cout << "newline found" << std::endl;
    // }
  }

  // Output the power reading
  // for(int kk = 0; kk < FREQLEVELS; kk++){
  //   for(int ii = 0; ii < NUMSOCKETS; ii++){
  //     for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
  //       std::cout << compute_bound_power[kk][ii][jj] << "\t";
  //     }
  //     std::cout << "\n";
  //   }
  // }

  infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_DVFS_CP");
  if(infile1.fail()){
    std::cout << "Failed to open power profile file!" << std::endl;
    std::cin.get();
    return 0;
  }
  //std::string token;
  while(std::getline(infile1, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    int freq = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        freq = stoi(token);
      }else{
        if(ii == 1){
          pwidth = stoi(token);
        }
        else{
          get_power = stof(token);
          memory_bound_power[freq][ii-2][pwidth] = get_power; 
        } 
      }
      ii++;
      //std::cout << "Token :" << token << std::endl;
    }
    // if(infile.unget().get() == '\n') {
    //   std::cout << "newline found" << std::endl;
    // }
  }

  // Output the power reading
  // for(int kk = 0; kk < FREQLEVELS; kk++){
  //   for(int ii = 0; ii < NUMSOCKETS; ii++){
  //     for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
  //       std::cout << memory_bound_power[kk][ii][jj] << "\t";
  //     }
  //     std::cout << "\n";
  //   }
  // }

#elif (defined CATA)
  // Denver Frequency: 2035200, A57 Frequency: 1113600
  infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/COMP_CATA.txt");
  std::string token;
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        compute_bound_power[ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  for(int ii = 0; ii < NUMSOCKETS; ii++){
    for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
      std::cout << compute_bound_power[ii][jj] << "\t";
    }
    std::cout << "\n";
  }
#else
#if (defined ERASE_target_energy_method1) || (defined ERASE_target_energy_method2) || (defined ERASE_target_edp_method1) || (defined ERASE_target_edp_method2)
#if (defined DynaDVFS)
  std::string token;
  // Compute-bound Power Models
  infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_MatMul.txt");
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        compute_bound_power[0][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_MatMul.txt");
  while(std::getline(infile1, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        compute_bound_power[3][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile.close();
  infile1.close();
  // Output Power Model profiles
  std::cout << "\nCompute-bound Power Model: \n";
  for(int cc = 0; cc < 4; cc+=3){
    for(int ii = 0; ii < NUMSOCKETS; ii++){
      for (int jj = 0; jj < gotao_nthreads; jj++){
        std::cout << compute_bound_power[cc][ii][jj] << "\t";
      }
      std::cout << "\n";
    }
  }
  // Memory-bound Power Models
  infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_Copy.txt");
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        memory_bound_power[0][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_Copy.txt");
  while(std::getline(infile1, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        memory_bound_power[3][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile.close();
  infile1.close();
  // Output Power Model profiles
  std::cout << "\nMemory-bound Power Model: \n";
  for(int cc = 0; cc < 4; cc+=3){
    for(int ii = 0; ii < NUMSOCKETS; ii++){
      for (int jj = 0; jj < gotao_nthreads; jj++){
        std::cout << memory_bound_power[cc][ii][jj] << "\t";
      }
      std::cout << "\n";
    }
  }
  // Cache-intensive Power Models
  infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_Stencil.txt");
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        cache_intensive_power[0][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_Stencil.txt");
  while(std::getline(infile1, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        cache_intensive_power[3][ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  infile.close();
  infile1.close();
  // Output Power Model profiles
  std::cout << "\nCache-intensive Power Model: \n";
  for(int cc = 0; cc < 4; cc+=3){
    for(int ii = 0; ii < NUMSOCKETS; ii++){
      for (int jj = 0; jj < gotao_nthreads; jj++){
        std::cout << cache_intensive_power[cc][ii][jj] << "\t";
      }
      std::cout << "\n";
    }
  }
#else
  if(denver_freq == 0 && a57_freq == 0){
    infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_MatMul.txt");
    infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_Copy.txt");
    infile2.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMAX_Stencil.txt");
  }
  if(denver_freq == 1 && a57_freq == 0){
    infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMAX_MatMul.txt");
    infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMAX_Copy.txt");
    infile2.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMAX_Stencil.txt");
  }
  if(denver_freq == 0 && a57_freq == 1){
    infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMIN_MatMul.txt");
    infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMIN_Copy.txt");
    infile2.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MAXMIN_Stencil.txt");
  }
  if(denver_freq == 1 && a57_freq == 1){
    infile.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_MatMul.txt");
    infile1.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_Copy.txt");
    infile2.open("/home/nvidia/Desktop/ERASE_TACO/PowerProfile/TX2_MINMIN_Stencil.txt");
  }
  if(infile.fail() || infile1.fail() || infile2.fail()){
    std::cout << "Failed to open power profile file!" << std::endl;
    std::cin.get();
    return 0;
  }

  std::string token;
  while(std::getline(infile, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        compute_bound_power[ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  // if(Sched == 1){
    // Output the power reading
  std::cout << "Compute-bound Power Model: \n";
  std::cout << "\t Idle \t w=1 \t w=2 \t w=4 \t total\n";
  for(int ii = 0; ii < NUMSOCKETS; ii++){
    if(ii == 0){
      std::cout << "D: ";
    }else{
      std::cout << "A: ";
    }
    for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
      std::cout << compute_bound_power[ii][jj] << "\t";
    }
    std::cout << "\n";
  }
  //}

  while(std::getline(infile1, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        memory_bound_power[ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  // if(Sched == 1){
    // Output the power reading
  std::cout << "\nMemory-bound Power Model: \n";
  for(int ii = 0; ii < NUMSOCKETS; ii++){
    for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
      std::cout << memory_bound_power[ii][jj] << "\t";
    }
    std::cout << "\n";
  }
  // }
  while(std::getline(infile2, token)) {
    std::istringstream line(token);
    int ii = 0;
    int pwidth = 0;
    float get_power = 0;
    while(line >> token) {
      if(ii == 0){
        pwidth = stoi(token);
      }else{
        get_power = stof(token);
        cache_intensive_power[ii-1][pwidth] = get_power; 
      }
      ii++;
    }
  }
  // if(Sched == 1){
    // Output the power reading
  std::cout << "\nCache-intensive Power Model: \n";
  for(int ii = 0; ii < NUMSOCKETS; ii++){
    for (int jj = 0; jj < XITAO_MAXTHREADS; jj++){
      std::cout << cache_intensive_power[ii][jj] << "\t";
    }
    std::cout << "\n";
  }
  // }
#endif
#endif
#endif
#endif

  const char* layout_file = getenv("XITAO_LAYOUT_PATH");
  if(!resources_runtime_conrolled) {
    if(layout_file) {
      int line_count = 0;
      int cluster_count = 0;
      std::string line;      
      std::ifstream myfile(layout_file);
      int current_thread_id = -1; // exclude the first iteration
      if (myfile.is_open()) {
        bool init_affinity = false;
        while (std::getline(myfile,line)) {         
          size_t pos = 0;
          std::string token;
          if(current_thread_id >= XITAO_MAXTHREADS) {
            std::cout << "Fatal error: there are more partitions than XITAO_MAXTHREADS of: " << XITAO_MAXTHREADS  << " in file: " << layout_file << std::endl;    
            exit(0);    
          }

          // if(line_count == 0){
          //   while ((pos = line.find(";")) != std::string::npos) {
          //     token = line.substr(0, pos);      
          //     int val = stoi(token);
          //     cluster_mapper[cluster_count] = val;
          //     cluster_count++;
          //     line.erase(0, pos + 1);
          //   }
          //   line_count++;
          //   continue;
          // }
          
          //if(line_count > 0){
          int thread_count = 0;
          while ((pos = line.find(",")) != std::string::npos) {
            token = line.substr(0, pos);      
            int val = stoi(token);
            if(!init_affinity) static_resource_mapper[thread_count++] = val;  
            else { 
              if(current_thread_id + 1 >= gotao_nthreads) {
                  std::cout << "Fatal error: more configurations than there are input threads in:" << layout_file << std::endl;    
                  exit(0);
              }
              ptt_layout[current_thread_id].push_back(val);
              for(int i = 0; i < val; ++i) {     
                if(current_thread_id + i >= XITAO_MAXTHREADS) {
                  std::cout << "Fatal error: illegal partition choices for thread: " << current_thread_id <<" spanning id: " << current_thread_id + i << " while having XITAO_MAXTHREADS: " << XITAO_MAXTHREADS  << " in file: " << layout_file << std::endl;    
                  exit(0);           
                }
                inclusive_partitions[current_thread_id + i].push_back(std::make_pair(current_thread_id, val)); 
              }              
            }            
            line.erase(0, pos + 1);
          }          
          //if(line_count > 1) {
            token = line.substr(0, line.size());      
            int val = stoi(token);
            if(!init_affinity) static_resource_mapper[thread_count++] = val;
            else { 
              ptt_layout[current_thread_id].push_back(val);
              for(int i = 0; i < val; ++i) {                
                if(current_thread_id + i >= XITAO_MAXTHREADS) {
                  std::cout << "Fatal error: illegal partition choices for thread: " << current_thread_id <<" spanning id: " << current_thread_id + i << " while having XITAO_MAXTHREADS: " << XITAO_MAXTHREADS  << " in file: " << layout_file << std::endl;    
                  exit(0);           
                }
                inclusive_partitions[current_thread_id + i].push_back(std::make_pair(current_thread_id, val)); 
              }              
            }            
          //}
          if(!init_affinity) { 
            gotao_nthreads = thread_count; 
            init_affinity = true;
          }
          current_thread_id++;    
          line_count++;     
          //}
        }
        myfile.close();
      } else {
        std::cout << "Fatal error: could not open hardware layout path " << layout_file << std::endl;    
        exit(0);
      }
    } else {
        std::cout << "Warning: XITAO_LAYOUT_PATH is not set. Default values for affinity and symmetric resoruce partitions will be used" << std::endl;    
        for(int i = 0; i < XITAO_MAXTHREADS; ++i) 
          static_resource_mapper[i] = i; 
        std::vector<int> widths;             
        int count = gotao_nthreads;        
        std::vector<int> temp;        // hold the big divisors, so that the final list of widths is in sorted order 
        for(int i = 1; i < sqrt(gotao_nthreads); ++i){ 
          if(gotao_nthreads % i == 0) {
            widths.push_back(i);
            temp.push_back(gotao_nthreads / i); 
          } 
        }
        std::reverse(temp.begin(), temp.end());
        widths.insert(widths.end(), temp.begin(), temp.end());
        //std::reverse(widths.begin(), widths.end());        
        for(int i = 0; i < widths.size(); ++i) {
          for(int j = 0; j < gotao_nthreads; j+=widths[i]){
            ptt_layout[j].push_back(widths[i]);
          }
        }

        for(int i = 0; i < gotao_nthreads; ++i){
          for(auto&& width : ptt_layout[i]){
            for(int j = 0; j < width; ++j) {                
              inclusive_partitions[i + j].push_back(std::make_pair(i, width)); 
            }         
          }
        }
      } 
  } else {    
    if(gotao_nthreads != runtime_resource_mapper.size()) {
      std::cout << "Warning: requested " << runtime_resource_mapper.size() << " at runtime, whereas gotao_nthreads is set to " << gotao_nthreads <<". Runtime value will be used" << std::endl;
      gotao_nthreads = runtime_resource_mapper.size();
    }            
  }
#ifdef DEBUG
	std::cout << "XiTAO initialized with " << gotao_nthreads << " threads and configured with " << XITAO_MAXTHREADS << " max threads " << std::endl;
  // std::cout << "The platform has " << cluster_mapper.size() << " clusters.\n";
  // for(int i = 0; i < cluster_mapper.size(); i++){
  //   std::cout << "[DEBUG] Cluster " << i << " has " << cluster_mapper[i] << " cores.\n";
  // }
  for(int i = 0; i < static_resource_mapper.size(); ++i) {
    std::cout << "[DEBUG] Thread " << i << " is configured to be mapped to core id : " << static_resource_mapper[i] << std::endl;
    std::cout << "[DEBUG] PTT Layout Size of thread " << i << " : " << ptt_layout[i].size() << std::endl;
    std::cout << "[DEBUG] Inclusive partition size of thread " << i << " : " << inclusive_partitions[i].size() << std::endl;
    std::cout << "[DEBUG] leader thread " << i << " has partition widths of : ";
    for (int j = 0; j < ptt_layout[i].size(); ++j){
      std::cout << ptt_layout[i][j] << " ";
    }
    std::cout << std::endl;
    std::cout << "[DEBUG] thread " << i << " is contained in these [leader,width] pairs : ";
    for (int j = 0; j < inclusive_partitions[i].size(); ++j){
      std::cout << "["<<inclusive_partitions[i][j].first << "," << inclusive_partitions[i][j].second << "]";
    }
    std::cout << std::endl;
  }
#endif

  if(nhwc>=0){
    gotao_ncontexts = nhwc;
  }
  else{
    if(getenv("GOTAO_HW_CONTEXTS")){
      gotao_ncontexts = atoi(getenv("GOTAO_HW_CONTEXTS"));
    }
    else{ 
      gotao_ncontexts = GOTAO_HW_CONTEXTS;
    }
  }

#if defined(Haswell)
  if(nhwc >= 0){
    num_sockets = nhwc;
  }
  else{
    if(getenv("NUMSOCKETS")){
      num_sockets = atoi(getenv("NUMSOCKETS"));
    }
    else{
      num_sockets = NUMSOCKETS;
    }
  } 
#endif

  if(thrb>=0){
    gotao_thread_base = thrb;
  }
  else{
    if(getenv("GOTAO_THREAD_BASE")){
      gotao_thread_base = atoi(getenv("GOTAO_THREAD_BASE"));
    }
    else{
      gotao_thread_base = GOTAO_THREAD_BASE;
    }
  }
/*
  starting_barrier = new BARRIER(gotao_nthreads + 1);
  tao_barrier = new cxx_barrier(2);
  for(int i = 0; i < gotao_nthreads; i++){
    t[i]  = new std::thread(worker_loop, i);   
  }
*/  
}

// drain the pipeline
void gotao_drain(){
  std::unique_lock<std::mutex> lk(pending_tasks_mutex);
  pending_tasks_cv.wait(lk, []{return PolyTask::pending_tasks <= 0;});
}

// Initialize gotao from environment vars or defaults
int gotao_init(int scheduler, int parallelism, int STEAL_DtoA, int STEAL_AtoD){
//  return gotao_init_hw(-1, -1, -1);
  starting_barrier = new BARRIER(gotao_nthreads);
  tao_barrier = new cxx_barrier(gotao_nthreads);
  for(int i = 0; i < gotao_nthreads; i++){
    t[i]  = new std::thread(worker_loop, i);
  }
  Sched = scheduler;
  Parallelism = parallelism;
  maySteal_DtoA = STEAL_DtoA;
  maySteal_AtoD = STEAL_AtoD;
#ifdef DynaDVFS
  // freq_dec = 0;
  // freq_inc = 0;
  current_freq = 2035200; // ERASE starting frequency is 2.04GHz for both clusters
  env = 0;
#endif
}

int gotao_start()
{
  /*
  if(Sched == 0){
  //Analyse DAG based on tasks in ready q and asign criticality values
  for(int j=0; j<gotao_nthreads; j++){
    //Iterate over all ready tasks for all threads
    for(std::list<PolyTask *>::iterator it = worker_ready_q[j].begin(); it != worker_ready_q[j].end(); ++it){
      //Call recursive function setting criticality
      (*it)->set_criticality();
    }
  }
  for(int j = 0; j < gotao_nthreads; j++){
    for(std::list<PolyTask *>::iterator it = worker_ready_q[j].begin(); it != worker_ready_q[j].end(); ++it){
      if ((*it)->criticality == critical_path){
        (*it)->marker = 1;
        (*it) -> set_marker(1);
        break;
      }
    }
  }
  }
  */
  starting_barrier->wait(gotao_nthreads+1);
}

int gotao_fini()
{
  resources_runtime_conrolled = false;
  gotao_can_exit = true;
  gotao_initialized = false;
  for(int i = 0; i < gotao_nthreads; i++){
    t[i]->join();
  }
}

void gotao_barrier()
{
  tao_barrier->wait();
}

int check_and_get_available_queue(int queue) {
  bool found = false;
  if(queue >= runtime_resource_mapper.size()) {
    return rand()%runtime_resource_mapper.size();
  } else {
    return queue;
  }  
}
// push work into polytask queue
// if no particular queue is specified then try to determine which is the local
// queue and insert it there. This has some overhead, so in general the
// programmer should specify some queue
int gotao_push(PolyTask *pt, int queue)
{
  if((queue == -1) && (pt->affinity_queue != -1)){
    queue = pt->affinity_queue;
  }
  else{
    if(queue == -1){
      queue = sched_getcpu();
    }
  }
  if(resources_runtime_conrolled) queue = check_and_get_available_queue(queue);
  LOCK_ACQUIRE(worker_lock[queue]);
  worker_ready_q[queue].push_front(pt);
  LOCK_RELEASE(worker_lock[queue]);
}

// Push work when not yet running. This version does not require locks
// Semantics are slightly different here
// 1. the tid refers to the logical core, before adjusting with gotao_thread_base
// 2. if the queue is not specified, then put everything into the first queue
int gotao_push_init(PolyTask *pt, int queue)
{
  if((queue == -1) && (pt->affinity_queue != -1)){
    queue = pt->affinity_queue;
  }
  else{
    if(queue == -1){
      queue = gotao_thread_base;
    }
  }
  if(resources_runtime_conrolled) queue = check_and_get_available_queue(queue);
  worker_ready_q[queue].push_front(pt);
}

// alternative version that pushes to the back
int gotao_push_back_init(PolyTask *pt, int queue)
{
  if((queue == -1) && (pt->affinity_queue != -1)){
    queue = pt->affinity_queue;
  }
  else{
    if(queue == -1){
      queue = gotao_thread_base;
    }
  }
  worker_ready_q[queue].push_back(pt);
}


long int r_rand(long int *s)
{
  *s = ((1140671485*(*s) + 12820163) % (1<<24));
  return *s;
}


void __xitao_lock()
{
  smpd_region_lock.lock();
  //LOCK_ACQUIRE(smpd_region_lock);
}
void __xitao_unlock()
{
  smpd_region_lock.unlock();
  //LOCK_RELEASE(smpd_region_lock);
}

int worker_loop(int nthread)
{
// #ifdef PERF_COUNTERS

// #endif
  // std::ofstream timetask;
  // timetask.open("data_process.sh", std::ios_base::app);

  int phys_core;
  if(resources_runtime_conrolled) {
    if(nthread >= runtime_resource_mapper.size()) {
      LOCK_ACQUIRE(output_lck);
      std::cout << "Error: thread cannot be created due to resource limitation" << std::endl;
      LOCK_RELEASE(output_lck);
      exit(0);
    }
    phys_core = runtime_resource_mapper[nthread];
  } else {
    phys_core = static_resource_mapper[gotao_thread_base+(nthread%(XITAO_MAXTHREADS-gotao_thread_base))];   
  }
#ifdef DEBUG
  LOCK_ACQUIRE(output_lck);
  std::cout << "[DEBUG] nthread: " << nthread << " mapped to physical core: "<< phys_core << std::endl;
  LOCK_RELEASE(output_lck);
#endif  
  unsigned int seed = time(NULL);
  cpu_set_t cpu_mask;
  CPU_ZERO(&cpu_mask);
  CPU_SET(phys_core, &cpu_mask);

  sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask); 
  // When resources are reclaimed, this will preempt the thread if it has no work in its local queue to do.
  
  PolyTask *st = nullptr;
  starting_barrier->wait(gotao_nthreads+1);  
  auto&&  partitions = inclusive_partitions[nthread];

#ifdef PERF_COUNTERS
  // Perf Event Counters
  struct perf_event_attr pea;
  int fd1, fd2, fd3, fd4, fd5, fd6;
  uint64_t id1, id2, id3, id4, id5, id6;
  uint64_t val1, val2, val3, val4, val5, val6;
  char buf[4096];
  struct read_format* rf = (struct read_format*) buf;

  memset(&pea, 0, sizeof(struct perf_event_attr));
  pea.type = PERF_TYPE_HARDWARE;
  pea.size = sizeof(struct perf_event_attr);
  pea.config = PERF_COUNT_HW_CPU_CYCLES;
  pea.disabled = 1;
  pea.exclude_kernel = 0;
  pea.exclude_hv = 1;
  pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
  fd1 = syscall(__NR_perf_event_open, &pea, 0, phys_core, -1, 0);
//  fd1 = syscall(__NR_perf_event_open, &pea, 0, -1, -1, 0);
  ioctl(fd1, PERF_EVENT_IOC_ID, &id1);

//   memset(&pea, 0, sizeof(struct perf_event_attr));
//   pea.type = PERF_TYPE_HARDWARE;
//   pea.size = sizeof(struct perf_event_attr);
//   pea.config = PERF_COUNT_HW_INSTRUCTIONS;
//   pea.disabled = 1;
//   pea.exclude_kernel = 0;
//   pea.exclude_hv = 1;
//   pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
//   fd2 = syscall(__NR_perf_event_open, &pea, 0, phys_core, fd1 /*!!!*/, 0);
// //  fd2 = syscall(__NR_perf_event_open, &pea, 0, -1, fd1 /*!!!*/, 0);
//   ioctl(fd2, PERF_EVENT_IOC_ID, &id2);

//   memset(&pea, 0, sizeof(struct perf_event_attr));
//     // pea.type = PERF_TYPE_HARDWARE;
//     pea.type = PERF_TYPE_HW_CACHE;
//     pea.size = sizeof(struct perf_event_attr);
//     // pea.config = PERF_COUNT_HW_CACHE_REFERENCES;
//     pea.config = (PERF_COUNT_HW_CACHE_L1D) | (PERF_COUNT_HW_CACHE_OP_READ << 8) | (PERF_COUNT_HW_CACHE_RESULT_ACCESS << 16);
//     pea.disabled = 1;
//     pea.exclude_kernel = 0;
//     pea.exclude_hv = 1;
//     pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
//     fd3 = syscall(__NR_perf_event_open, &pea, 0, phys_core, fd1 /*!!!*/, 0);
// //    fd3 = syscall(__NR_perf_event_open, &pea, 0, 3, fd1 /*!!!*/, 0);
//     ioctl(fd3, PERF_EVENT_IOC_ID, &id3);

//     memset(&pea, 0, sizeof(struct perf_event_attr));
//     // pea.type = PERF_TYPE_HARDWARE;
//     pea.type = PERF_TYPE_HW_CACHE;
//     pea.size = sizeof(struct perf_event_attr);
//     // pea.config = PERF_COUNT_HW_CACHE_MISSES;
//     pea.config = (PERF_COUNT_HW_CACHE_L1D) | (PERF_COUNT_HW_CACHE_OP_READ << 8) | (PERF_COUNT_HW_CACHE_RESULT_MISS << 16);
//     pea.disabled = 1;
//     pea.exclude_kernel = 0;
//     pea.exclude_hv = 1;
//     pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
//     fd4 = syscall(__NR_perf_event_open, &pea, 0, phys_core, fd1 /*!!!*/, 0);
// //    fd4 = syscall(__NR_perf_event_open, &pea, 0, 3, fd1 /*!!!*/, 0);
//     ioctl(fd4, PERF_EVENT_IOC_ID, &id4);

//     memset(&pea, 0, sizeof(struct perf_event_attr));
//     pea.type = PERF_TYPE_RAW;
//     pea.size = sizeof(struct perf_event_attr);
//     pea.config = 0x16;
//     pea.disabled = 1;
//     pea.exclude_kernel = 0;
//     pea.exclude_hv = 1;
//     pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
//     fd5 = syscall(__NR_perf_event_open, &pea, 0, phys_core, fd1, 0);
// //    fd5 = syscall(__NR_perf_event_open, &pea, 0, 3, fd1, 0);
//     ioctl(fd5, PERF_EVENT_IOC_ID, &id5);

//     memset(&pea, 0, sizeof(struct perf_event_attr));
//     pea.type = PERF_TYPE_RAW;
//     pea.size = sizeof(struct perf_event_attr);
//     pea.config = 0x17;
//     pea.disabled = 1;
//     pea.exclude_kernel = 0;
//     pea.exclude_hv = 1;
//     pea.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
//     fd6 = syscall(__NR_perf_event_open, &pea, 0, phys_core, fd1, 0);
// //    fd6 = syscall(__NR_perf_event_open, &pea, 0, 3, fd1, 0);
//     ioctl(fd6, PERF_EVENT_IOC_ID, &id6);
#endif

  int idle_try = 0;
  int idle_times = 0;
  int SleepNum = 0;
  int AccumTime = 0;

  if(Sched == 1){
    for(int i=0; i<XITAO_MAXTHREADS; i++){ 
      status[i] = 1;
      status_working[i] = 1;
      //for(int j=0; j < XITAO_MAXTHREADS; j++){
      //  PTT_flag[i][j] = 1;
      //}
    }
  }
  bool stop = false;

  // Accumulation of tasks execution time
  // Goal: Get runtime idle time
#ifdef EXECTIME
  //std::chrono::time_point<std::chrono::system_clock> idle_start, idle_end;
  std::chrono::duration<double> elapsed_exe{}; // Add {}, tick count is zero-initialized 
#endif

#ifdef OVERHEAD_PTT
  std::chrono::duration<double> elapsed_ptt;
#endif

#ifdef PTTaccuracy
  float MAE = 0.0f;
  std::ofstream PTT("PTT_Accuracy.txt");
#endif

#ifdef Energyaccuracy
  float EnergyPrediction = 0.0f;
#endif

  while(true)
  {    
    int random_core = 0;
    AssemblyTask *assembly = nullptr;
    SimpleTask *simple = nullptr;

  // 0. If a task is already provided via forwarding then exeucute it (simple task)
  //    or insert it into the assembly queues (assembly task)
    if( st && !stop){
      if(st->type == TASK_SIMPLE){
        SimpleTask *simple = (SimpleTask *) st;
        simple->f(simple->args, nthread);

  #ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout << "[DEBUG] Distributing simple task " << simple->taskid << " with width " << simple->width << " to workers " << nthread << std::endl;
        LOCK_RELEASE(output_lck);
  #endif
  #ifdef OVERHEAD_PTT
        st = simple->commit_and_wakeup(nthread, elapsed_ptt);
  #else
        st = simple->commit_and_wakeup(nthread);
  #endif
        simple->cleanup();
        //delete simple;
      }
      else 
      if(st->type == TASK_ASSEMBLY){
        AssemblyTask *assembly = (AssemblyTask *) st;
#if defined(TX2)
        if(Sched == 3){
          assembly->leader = nthread / assembly->width * assembly->width; // homogenous calculation of leader core
        }
#endif
#if defined(Haswell) || defined(CATS)
        assembly->leader = nthread / assembly->width * assembly->width;
#endif

#ifdef KMEANS
        if(Sched == 0){
          int pr = assembly->if_prio(nthread, assembly);
          if (pr == 1){
            //std::cout << "Enter"
            assembly->globalsearch_Perf(nthread, assembly);
            for(int i = assembly->leader; i < assembly->leader + assembly->width; i++){
              LOCK_ACQUIRE(worker_assembly_lock[i]);
              worker_assembly_q[i].push_back(assembly);
            }
            for(int i = assembly->leader; i < assembly->leader + assembly->width; i++){
              LOCK_RELEASE(worker_assembly_lock[i]);
            }
            
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout <<"[DEBUG] Priority=1, task "<< assembly->taskid <<" will run on thread "<< assembly->leader << ", width become " << assembly->width << std::endl;
            LOCK_RELEASE(output_lck);
#endif
          }
          else{
        	  assembly->history_mold(nthread, assembly);   
            LOCK_ACQUIRE(worker_lock[assembly->leader]);
        	  worker_ready_q[assembly->leader].push_back(assembly);
        	  LOCK_RELEASE(worker_lock[assembly->leader]);
            
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
				    std::cout <<"[DEBUG] Priority=0, task "<< assembly->taskid <<" is pushed to WSQ of thread "<< nthread << std::endl;
            LOCK_RELEASE(output_lck);
#endif
          }
        }
        if((Sched == 1) || (Sched == 2)){
        	assembly->ERASE_Target_Energy(nthread, assembly);
          //std::cout << "Glocal Search!\n";
				}  
#endif
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout << "[DEBUG] Distributing assembly task " << assembly->taskid << " with width " << assembly->width << " to workers [" << assembly->leader << "," << assembly->leader + assembly->width << ")" << std::endl;
        LOCK_RELEASE(output_lck);
#endif
        // std::cout << "Task: " << assembly->kernel_name << "\n";
        for(int i = assembly->leader; i < assembly->leader + assembly->width; i++){
          LOCK_ACQUIRE(worker_assembly_lock[i]);
          worker_assembly_q[i].push_back(st);
#ifdef NUMTASKS_MIX
#ifdef ONLYCRITICAL
          int pr = assembly->if_prio(nthread, assembly);
          if(pr == 1){
#endif
            num_task[assembly->kernel_index][assembly->width * gotao_nthreads + i]++;
#ifdef ONLYCRITICAL
          }
#endif
#endif
        }
        for(int i = assembly->leader; i < assembly->leader + assembly->width; i++){
          LOCK_RELEASE(worker_assembly_lock[i]);
        }
        st = nullptr;
      }
      continue;
    }

  // 1. check for assemblies
    if(!worker_assembly_q[nthread].pop_front(&st)){
      st = nullptr;
    }
  // assemblies are inlined between two barriers
    if(st) {
      int _final; // remaining
      assembly = (AssemblyTask *) st;

#ifdef NEED_BARRIER
      //BARRIER *barrier;
//       assembly->barrier = new BARRIER(assembly->width);
// #ifdef DEBUG
//       LOCK_ACQUIRE(output_lck);
//       std::cout <<"[BARRIER] Task "<< assembly->taskid << " create a barrier, width is  " << assembly->width << std::endl;
//       LOCK_RELEASE(output_lck);
// #endif

      if(assembly->width > 1){
        assembly->barrier->wait(assembly->width);
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout <<"[BARRIER-Before] For Task " << assembly->taskid << ", thread "<< nthread << " arrives." << std::endl;
        LOCK_RELEASE(output_lck);
#endif
      }
#endif
      
//       if(Sched == 1 && assembly->leader == nthread){
//         int width_index = assembly->width - 1;
// #ifdef DVFS
//         if(nthread < 2){
//           PTT_UpdateFlag[denver_freq][nthread][width_index]++;
//         }else{
//           PTT_UpdateFlag[a57_freq][nthread][width_index]++;
//         }
// #else
//         PTT_UpdateFlag[nthread][width_index]++;
// #ifdef DEBUG
//         LOCK_ACQUIRE(output_lck);
//         std::cout << "[DEBUG] PTT_UpdateFlag[" << nthread << "][" << width_index << "] = " << PTT_UpdateFlag[nthread][width_index] << std::endl;
//         LOCK_RELEASE(output_lck);
// #endif  
// #endif
//       }

#ifdef DEBUG
      LOCK_ACQUIRE(output_lck);
      std::cout << "[DEBUG] Thread "<< nthread << " starts executing " << assembly->kernel_name << " task " << assembly->taskid << "......\n";
      LOCK_RELEASE(output_lck);
#endif
#ifdef STEER_TH_ANALYSIS
      if(assembly->taskid % 16 >= 6 && assembly->taskid % 16 <= 9){  /* TH = 0.002s: Only BMOD tasks change the frequency */  
        int freq_change_cluster_active = std::accumulate(status_working + 0, status_working + 2, 0); /* Check if there is any task running on Denver cluster? Yes, take the average, no, change the frequency to the required! */
#ifdef STEER_AVERAGE
        if(freq_change_cluster_active > 0){
          cur_freq_index[0] = (cur_freq_index[0] + 7) / 2; // 7=>960000 AVERAGE
          Denver << std::to_string(avail_freq[cur_freq_index[0]]) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to " << avail_freq[cur_freq_index[0]] << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }else{
          cur_freq_index[0] = 7;
          Denver << std::to_string(960000) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 0.96GHz (No ave) " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }
#endif
#ifdef STEER_HIGH
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] > 7){
            cur_freq_index[0] = 7;
            Denver << std::to_string(960000) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 0.96GHz (current freq is lower) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
          }
        }else{
          cur_freq_index[0] = 7;
          Denver << std::to_string(960000) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 0.96GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
        }
#endif
#ifdef STEER_LOW
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] < 7){
            cur_freq_index[0] = 7;
            Denver << std::to_string(960000) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[LOW] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 0.96GHz (current freq is higher) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif          
          }
        }else{
          cur_freq_index[0] = 7;
          Denver << std::to_string(960000) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[LOW] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 0.96GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif 
        }
#endif
      }
      else{
        if(assembly->taskid % 16 >= 2 && assembly->taskid % 16 <= 3){ /* TH = 0.0005s: FWD change frequency to 1.27GHz*/
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[JING] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz. " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        int freq_change_cluster_active = std::accumulate(status_working + 0, status_working + 2, 0); /* Check if there is any task running on Denver cluster? Yes, take the average, no, change the frequency to the required! */
#ifdef STEER_AVERAGE
        if(freq_change_cluster_active > 0){
          cur_freq_index[0] = (cur_freq_index[0] + 5) / 2; // 5=>1267200 AVERAGE
          Denver << std::to_string(avail_freq[cur_freq_index[0]]) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to " << avail_freq[cur_freq_index[0]] << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }else{
          cur_freq_index[0] = 5;
          Denver << std::to_string(1267200) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz (No ave) " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }
#endif
#ifdef STEER_HIGH
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] > 5){
            cur_freq_index[0] = 5;
            Denver << std::to_string(1267200) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz (current freq is lower) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
          }
        }else{
          cur_freq_index[0] = 5;
          Denver << std::to_string(1267200) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
        }
#endif
#ifdef STEER_LOW
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] < 5){
            cur_freq_index[0] = 5;
            Denver << std::to_string(1267200) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz (current freq is higher) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif          
          }
        }else{
          cur_freq_index[0] = 5;
          Denver << std::to_string(1267200) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.27GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
        }
#endif
          //   Denver << std::to_string(960000) << std::endl;
          // Denver << std::to_string(1267200) << std::endl;
        }
        if(assembly->taskid % 16 >= 4 && assembly->taskid % 16 <= 5){ /* TH = 0.0005s: BDIV change frequency to 1.11GHz*/
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[JING] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz. " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        int freq_change_cluster_active = std::accumulate(status_working + 0, status_working + 2, 0); /* Check if there is any task running on Denver cluster? Yes, take the average, no, change the frequency to the required! */
#ifdef STEER_AVERAGE
        if(freq_change_cluster_active > 0){
          cur_freq_index[0] = (cur_freq_index[0] + 6) / 2; // 6=>1113600 AVERAGE
          Denver << std::to_string(avail_freq[cur_freq_index[0]]) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz. " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }else{
          cur_freq_index[0] = 6;
          Denver << std::to_string(1113600) << std::endl;
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[AVE] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz (No ave) " << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
        }
#endif
#ifdef STEER_HIGH
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] > 6){
            cur_freq_index[0] = 6;
            Denver << std::to_string(1113600) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz (current freq is lower) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif    
          }
        }else{
          cur_freq_index[0] = 6;
          Denver << std::to_string(1113600) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif    
        }
#endif
#ifdef STEER_LOW
        if(freq_change_cluster_active > 0 && cur_freq_index[0] !=0){
          if(cur_freq_index[0] < 6){
            cur_freq_index[0] = 6;
            Denver << std::to_string(1113600) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz (current freq is higher) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif
          }
        }else{
          cur_freq_index[0] = 6;
          Denver << std::to_string(1113600) << std::endl;
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[HIGH] " << assembly->kernel_name << " task " << assembly->taskid << " change frequency to 1.11GHz (current freq is 2.04GHz) " << std::endl;
          LOCK_RELEASE(output_lck);
#endif        
        }
#endif
          // Denver << std::to_string(1113600) << std::endl;
        }
      }
      // Per task DVFS TH:0.00025s
      // if(assembly->kernel_index == 0){ 
      //   Denver << std::to_string(1113600) << std::endl;
      // }
      // if(assembly->kernel_index == 1){ 
      //   Denver << std::to_string(1267200) << std::endl;
      // }
      // if(assembly->kernel_index == 2){
      //   Denver << std::to_string(1113600) << std::endl;
      // }
      // if(assembly->kernel_index == 3){
      //   Denver << std::to_string(960000) << std::endl;
      // }
#endif
      std::chrono::time_point<std::chrono::system_clock> t1,t2;
      t1 = std::chrono::system_clock::now();
// #ifdef PowerProfiling
      auto start1_ms = std::chrono::time_point_cast<std::chrono::milliseconds>(t1);
      auto epoch1 = start1_ms.time_since_epoch();
// #endif
#ifdef PERF_COUNTERS
      ioctl(fd1, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
      ioctl(fd1, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
#endif
      assembly->execute(nthread);
#ifdef PERF_COUNTERS
      ioctl(fd1, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
      read(fd1, buf, sizeof(buf));
      for (int i = 0; i < rf->nr; i++){
        if (rf->values[i].id == id1) {
            val1 = rf->values[i].value;
        } 
        // else if (rf->values[i].id == id2) {
        //     val2 = rf->values[i].value;
        // }else if (rf->values[i].id == id3) {
        //     val3 = rf->values[i].value;
        // }else if (rf->values[i].id == id4) {
        //     val4 = rf->values[i].value;
        // }else if (rf->values[i].id == id5) {
        //     val5 = rf->values[i].value;
        // }else if (rf->values[i].id == id6) {
        //     val6 = rf->values[i].value;
        // }
      }
#ifdef DEBUG
      LOCK_ACQUIRE(output_lck);
      // pmc <<"Thread " << nthread << ", " << val1 << ", " << val2 << ", " << val3 << ", " << val4 << ", " << val5 << ", " << val6 << ", ";
      std::cout <<"[DEBUG] Task " << assembly->taskid << " on thread " << nthread << ", cycles: " << val1 << "\n";
      LOCK_RELEASE(output_lck);
#endif
#endif
      //LOCK_ACQUIRE(worker_lock[nthread]);
      //status[nthread]--;
      //LOCK_RELEASE(worker_lock[nthread]);
      //status[nthread].fetch_sub(1, std::memory_order_relaxed);
      //std::atomic_fetch_sub(&status[nthread], 1);
      t2 = std::chrono::system_clock::now();
      std::chrono::duration<double> elapsed_seconds = t2-t1;

      auto end1_ms = std::chrono::time_point_cast<std::chrono::milliseconds>(t2);
      auto epoch1_end = end1_ms.time_since_epoch();
      // timetask << "python Energy.py " << epoch1.count() << "\t" <<  epoch1_end.count() << "\n";
#ifdef PERF_COUNTERS
      LOCK_ACQUIRE(output_lck);
      pmc << epoch1.count() << "\t" <<  epoch1_end.count() << "\t" << assembly->kernel_name << "\t" << elapsed_seconds.count() << "\n";
      pmc.flush();
      LOCK_RELEASE(output_lck);
      // std::cout << epoch1.count() << "\t" << epoch1_end.count() << "\n";
#endif
#ifdef PowerProfiling
      out << assembly->kernel_name << "\t" << epoch1.count() << "\t" << epoch1_end.count() << "\n";
      out.flush();
#endif
      // double ticks = elapsed_seconds.count();
#ifdef DEBUG
      LOCK_ACQUIRE(output_lck);
      std::cout << "[DEBUG] Task " << assembly->taskid << " execution time on thread " << nthread << " is: " << elapsed_seconds.count() << "\n";
      LOCK_RELEASE(output_lck);
#endif 
#ifdef NEED_BARRIER
      if(assembly->width > 1){
        assembly->barrier->wait(assembly->width);
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout <<"[BARRIER-After] For Task " << assembly->taskid << " thread  "<< nthread << " arrives." << std::endl;
        LOCK_RELEASE(output_lck);
#endif
      }
#endif
#ifdef EXECTIME
        elapsed_exe += elapsed_seconds;
#endif

#ifndef MultipleKernels
      if(Sched == 1 && !ptt_full){
#else
      if(Sched == 1){
#endif
        // if(assembly->leader == nthread){
          double ticks = elapsed_seconds.count();
          if(ticks > 0.00001){ // Make sure that tables are not updated by some null starter tasks 
          int width_index = assembly->width - 1;
          //Weight the newly recorded ticks to the old ticks 1:4 and save
#if (defined TX2) && (defined DVFS)
          // Old DVFS code: PTT is defined for each frequency level - Not scalable 
          if(nthread < 2){
            float oldticks = assembly->get_timetable(denver_freq, nthread, width_index);
            if(oldticks == 0){
              assembly->set_timetable(denver_freq, nthread,ticks,width_index);  
            }
            else {
              assembly->set_timetable(denver_freq, nthread,((4*oldticks+ticks)/5),width_index);         
            }
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout << "[DVFS] Task " << assembly->taskid << ", 1) on Denver execution time: " << ticks << ", " << "assembly->get_timetable(" << denver_freq << "," << nthread << "," << width_index <<") = " << assembly->get_timetable(denver_freq, nthread,width_index) << "\n";
            LOCK_RELEASE(output_lck);
#endif 
          }else{
            float oldticks = assembly->get_timetable(a57_freq, nthread,width_index);
            if(oldticks == 0){
              assembly->set_timetable(a57_freq, nthread,ticks,width_index);  
            }
            else {
              assembly->set_timetable(a57_freq, nthread,((4*oldticks+ticks)/5),width_index);         
            }
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout << "[DVFS] Task " << assembly->taskid << ", 1) on A57 execution time: " << ticks << ", after updating, time is " << assembly->get_timetable( a57_freq, nthread,width_index) << "\n";
            LOCK_RELEASE(output_lck);
#endif 
          }
#elif (defined DynaDVFS) && (defined PERF_COUNTERS)
          // 2021 - 08 - 24 TACO Review of Experiemnts: ERASE Reaction to Dynamic DVFS Change 
          
          float oldticks = assembly->get_timetable(nthread,width_index);
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[DEBUG] oldticks = " << oldticks << ". Increase/decrease(%): " << abs(ticks - oldticks)/oldticks << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif
          if(oldticks == 0){
            assembly->set_timetable(nthread,ticks,width_index);  
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout << "[DEBUG] Oldticks=0. New updated execution time = " << ticks << " by task " << assembly->taskid << std::endl;
            LOCK_RELEASE(output_lck);
#endif            
          }else{
            int computed_freq = val1 / (ticks*1000);
            float freq_deviation = fabs(1 - (float)computed_freq/(float)current_freq);
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout << "[DEBUG] computed freq = " << computed_freq << ". Real frequency = " << current_freq << ". Deviation = " << freq_deviation*100 << "%." << std::endl;
            LOCK_RELEASE(output_lck);
#endif
            // Frequency devistion < 3% => frequency is not changed
            if(freq_deviation < 0.03){
              assembly->set_timetable(nthread,((4*oldticks + ticks)/5),width_index);
            }else{
              std::ifstream freq_file;
              freq_file.open("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq");
              if(freq_file.fail()){
                std::cout << "Failed to open sys frequency reading file!" << std::endl;
                std::cin.get();
                return 0;
              }
              int reading_freq = 0;
              while(freq_file >> reading_freq); // Read value and store in reading_freq
              freq_file.close();
              if(reading_freq != current_freq){ // Check again if the frequency changed or not
                current_freq = reading_freq; // changed, rewrite the current frequency
                for(int leader = 0; leader < ptt_layout.size(); ++leader) { // Reset PTT entries to zeros
                  for(auto&& width : ptt_layout[leader]) {
                    assembly->set_timetable(leader,0.0,width-1);
                  }
                }
                ptt_full = false;
                assembly->set_timetable(nthread,ticks,width_index);
#ifdef DEBUG
                LOCK_ACQUIRE(output_lck);
                std::cout << "[DEBUG] Frequency change is confirmed. current frequency = " << current_freq << ". Reset PTT = 0. PTT_full = false. Task " << assembly->taskid << " update PTT(" \
                << nthread << "," << assembly->width << ") with new time " << ticks << std::endl;
                LOCK_RELEASE(output_lck);
#endif
              } 
            }

            // Scalable Alternative: Detect the new execution time, if the difference between the old and the new is 
            // more than 10% (confidence interval), consider the runtime is doing frequency change, then reset the value
            // in this cell. If detecting n (=5) cases, then we are sure there is a frequency change. Reset other values
            // to zero and retrain the PTT table.

//             // float rate = abs(float)(ticks - oldticks)/(float)oldticks;
//             float rate = fabs(1 - (float)ticks/(float)oldticks);
//             if(rate < 0.3){
//               assembly->set_timetable(nthread,((4*oldticks + ticks)/5),width_index);
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] |OldTime-NewTime|<30%. oldticks = " << oldticks << ". Increase/decrease(%): " << rate \
//               << ". Task " << assembly->taskid << " update time with weight(1/5). After updating: " << (4*oldticks + ticks)/5 << std::endl;
//               LOCK_RELEASE(output_lck);
// #endif
//             }else{
//             //if((float)(abs(ticks - oldticks))/oldticks >= 0.15){
//               dynamic_time_change++;
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] Consider frequency change: |OldTime-NewTime|>=30%. Oldticks: " << oldticks << ". Update with the new value from Task " \
//               << assembly->taskid << ": " << ticks << ". Dynamic_time_change = " << dynamic_time_change << std::endl;
//               LOCK_RELEASE(output_lck);
// #endif
//               if (ticks > oldticks){
//                 freq_dec++; // Frequency is decreasing
//               }else{
//                 freq_inc++; // Frequency is increasing
//               }

//               if(dynamic_time_change > 4){
// #ifdef DEBUG
//                 LOCK_ACQUIRE(output_lck);
//                 std::cout << "[DEBUG] >4 tasks show frequency change. Reset all PTT entries to zeros." << std::endl;
//                 LOCK_RELEASE(output_lck);
// #endif
//                 // Reset PTT entries to zeros
//                 for(int leader = 0; leader < ptt_layout.size(); ++leader) {
//                   for(auto&& width : ptt_layout[leader]) {
//                     assembly->set_timetable(leader,0.0,width-1);
//                   }
//                 }
//                 ptt_full = false;
//                 dynamic_time_change = 0;
//               }
//               assembly->set_timetable(nthread,ticks,width_index);
//             }
          }
          
#else
          float oldticks = assembly->get_timetable(assembly->leader,width_index);
          if(oldticks == 0.0){
            assembly->set_timetable(assembly->leader,ticks,width_index);  
          }
          else {
#ifdef PTTaccuracy
            /* Final PTT accuracy = SUM up all MAE and divided by number of tasks then multiply 100% */
            if(assembly->finalpredtime != 0.0f){
              MAE += 1 - (fabs(ticks - assembly->finalpredtime) / ticks);
              PTT << ticks << "\t" << assembly->finalpredtime << "\n";
#ifdef DEBUG
              LOCK_ACQUIRE(output_lck);
              std::cout << "[DEBUG] Task " << assembly-> taskid << " time prediction: " << assembly->finalpredtime << ", execution time: " << ticks << ", error: " << fabs(ticks - assembly->finalpredtime) << ", MAE = " << MAE << std::endl;
              LOCK_RELEASE(output_lck);
#endif
            }
#endif
            assembly->set_timetable(assembly->leader,((oldticks + ticks)/2),width_index);         
          }
// #ifdef DEBUG
//           LOCK_ACQUIRE(output_lck);
//           std::cout << "[DEBUG] Task " << assembly-> taskid << ", execution time: " << ticks << ", after updating, time is " << assembly->get_timetable( nthread,width_index) << std::endl;
//           LOCK_RELEASE(output_lck);
// #endif  
#endif
#ifdef Energyaccuracy
#if (defined TX2) && (defined MultipleKernels)
            if(assembly->finalenergypred == 0.0f){
              if(assembly->finalpowerpred != 0.0f){
                assembly->finalenergypred = assembly->finalpowerpred * ticks;
              }else{
                if(assembly->tasktype == 0){
                  assembly->finalpowerpred = (nthread < 2)? (compute_bound_power[0][assembly->width] +compute_bound_power[0][0]): (compute_bound_power[1][assembly->width]+compute_bound_power[1][0]);
                  assembly->finalenergypred = assembly->finalpowerpred * ticks;
                }else{
                  if(assembly->tasktype == 1){
                    assembly->finalpowerpred = (nthread < 2)? memory_bound_power[0][assembly->width] +memory_bound_power[0][0] : memory_bound_power[1][assembly->width] +memory_bound_power[1][0];
                    assembly->finalenergypred = assembly->finalpowerpred * ticks;
                  }
                }
              }
            }
#ifdef DEBUG
            LOCK_ACQUIRE(output_lck);
            std::cout << "[DEBUG] Task " << assembly->taskid <<" execution time = " << ticks << ", Predicted energy / power =  " << assembly->finalenergypred << ". \n";
            LOCK_RELEASE(output_lck);
#endif
#endif
#ifndef MultipleKernels
          if(ptt_full)
#endif
          {
            EnergyPrediction += assembly->finalenergypred;
          }
#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[DEBUG] Thread " << nthread << " energy pred sum =  " << EnergyPrediction << std::endl;
          LOCK_RELEASE(output_lck);
#endif  
#endif
        }
      }
#ifndef CATS    
    if(Sched == 0){ // CALC Test, update with all execution time
      double ticks = elapsed_seconds.count();
      if(ticks > 0.00001){ // Make sure that tables are not updated by some null starter tasks 
      int width_index = assembly->width - 1;
      float oldticks = assembly->get_timetable(assembly->leader,width_index);
      //std::cout << "oldticks = " << oldticks << std::endl;
      if(oldticks == 0.0f){
        assembly->set_timetable(assembly->leader,ticks,width_index);  
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
      	std::cout << "Update with new value (since =0)" << std::endl;
        LOCK_RELEASE(output_lck);
#endif
      }else {
        assembly->set_timetable(assembly->leader,((oldticks + ticks)/2),width_index);
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout << "Update with half half new value (since !=0)" << std::endl;
        LOCK_RELEASE(output_lck);
#endif       
      }
      }
    }
#endif
    
    _final = (++assembly->threads_out_tao == assembly->width);
    st = nullptr;
    if(_final){ // the last exiting thread updates
      task_completions[nthread].tasks++;
      if(task_completions[nthread].tasks > 0){
        PolyTask::pending_tasks -= task_completions[nthread].tasks;
#ifdef DEBUG
        LOCK_ACQUIRE(output_lck);
        std::cout << "[DEBUG] Thread " << nthread << " completed " << task_completions[nthread].tasks << " tasks. Pending tasks = " << PolyTask::pending_tasks << ". task_pool[" << nthread << "] = " << task_pool[nthread].tasks << "\n";
        LOCK_RELEASE(output_lck);
#endif
        task_completions[nthread].tasks = 0;
      }
      
#ifdef OVERHEAD_PTT
      st = assembly->commit_and_wakeup(nthread, elapsed_ptt);
#else
      st = assembly->commit_and_wakeup(nthread);
#endif
      assembly->cleanup();
    }
    idle_try = 0;
    idle_times = 0;
    continue;
  }

    // 2. check own queue
    if(!stop){
      LOCK_ACQUIRE(worker_lock[nthread]);
      if(!worker_ready_q[nthread].empty()){
        st = worker_ready_q[nthread].front(); 
        worker_ready_q[nthread].pop_front();
        LOCK_RELEASE(worker_lock[nthread]);
        continue;
      }     
      LOCK_RELEASE(worker_lock[nthread]);        
    }

#ifdef WORK_STEALING
// #ifdef DEBUG
//       LOCK_ACQUIRE(output_lck);
//       std::cout << "[Test] Thread " << nthread << " goes out of work stealing.\n";
//       LOCK_RELEASE(output_lck);          
// #endif

    // 3. try to steal rand_r(&seed)
// #ifdef ERASE_target_edp
//     if((rand() % A57_best_edp_width == 0) && !stop)
// #else
    if((rand() % STEAL_ATTEMPTS == 0) && !stop)
// #endif
    {
      status_working[nthread] = 0;
      int attempts = gotao_nthreads;
#ifdef SLEEP
#if (defined RWSS_SLEEP)
      if(Sched == 3){
        idle_try++;
      }

#endif
#if (defined FCAS_SLEEP)
      if(Sched == 0){
        idle_try++;
      }
#endif
#if (defined EAS_SLEEP)
      if(Sched == 1){
        idle_try++;
      }
#endif
#endif

      do{
        if(Sched == 2){
          if(DtoA <= maySteal_DtoA){
            do{
              random_core = (rand_r(&seed) % gotao_nthreads);
            } while(random_core == nthread);
           
          }
          else{
            if(nthread < 2){
              do{
                random_core = (rand_r(&seed) % 2);
              } while(random_core == nthread);
            }else{
         	    do{
                random_core = 2 + (rand_r(&seed) % 4);
              }while(random_core == nthread); 
            }
          }
        }
        //EAS
        if(Sched == 1){
#if defined(TX2)
#ifndef MultipleKernels
        	if(!ptt_full){
          	do{
            	random_core = (rand_r(&seed) % gotao_nthreads);
          	} while(random_core == nthread);
        	}else
#endif
          // {
// #if (defined ERASE_target_perf) || (defined ERASE_target_edp_method1)
//           if(D_give_A == 0 || steal_DtoA < D_give_A){
//             int Denver_workload = worker_ready_q[0].size() + worker_ready_q[1].size();
//             int A57_workload = worker_ready_q[2].size() + worker_ready_q[3].size() + worker_ready_q[4].size() + worker_ready_q[5].size();
//           // If there is more workload to share with A57 
//             D_give_A = (Denver_workload-A57_workload) > 0? floor((Denver_workload-A57_workload) * 1 / (D_A+1)) : 0; 
//             //if((Denver_workload-A57_workload) > 0 && D_give_A > 0){
//             if(D_give_A > 0){
//               random_core = rand_r(&seed) % 2;
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] There is more workload that can be shared with A57. Size =  " << D_give_A << ". \n";
//               LOCK_RELEASE(output_lck);          
// #endif
//             }
//           }else
// #endif
          { 
          	// [EAS] Only steal tasks from same cluster
          	if(nthread < 2){
            	do{
              	random_core = (rand_r(&seed) % 2);
            	} while(random_core == nthread );
          	}else{
         	  	do{
              	random_core = 2 + (rand_r(&seed) % 4);
            	}while(random_core == nthread ); 
          	}
					}    
        // }
#endif
#if defined(Haswell)
          // if(nthread < gotao_nthreads/NUMSOCKETS){
          //   do{
          //     random_core = (rand_r(&seed) % (gotao_nthreads/NUMSOCKETS));
          //   } while(random_core == nthread);
          // }else{
          //   do{
          //     random_core = (gotao_nthreads/NUMSOCKETS) + (rand_r(&seed) % (gotao_nthreads/NUMSOCKETS));
          //   } while(random_core == nthread);
          // }
          do{
            random_core = (rand_r(&seed) % gotao_nthreads);
          } while(random_core == nthread);
#endif
        }

        if(Sched == 0){
#ifdef CATS
          if(denver_freq == 1 && a57_freq == 0){
            if(nthread < 2){
              do{
                random_core = rand_r(&seed) % 2;
              } while(random_core == nthread);
            }else{
              do{
                random_core = (rand_r(&seed) % gotao_nthreads);
              } while(random_core == nthread);
            }
          }else{
            if(nthread > 1){
              do{
                random_core = 2 + (rand_r(&seed) % 4);
              } while(random_core == nthread);
            }else{
              do{
                random_core = (rand_r(&seed) % gotao_nthreads);
              } while(random_core == nthread);
            }
          }  
#else
				  do{
            random_core = (rand_r(&seed) % gotao_nthreads);
          } while(random_core == nthread);
#endif
        }

        if(Sched == 3){
				  do{
            random_core = (rand_r(&seed) % gotao_nthreads);
          } while(random_core == nthread);
				}

        LOCK_ACQUIRE(worker_lock[random_core]);
        if(!worker_ready_q[random_core].empty()){
          st = worker_ready_q[random_core].back();
					if((Sched == 1) || (Sched == 2)){
            // [EAS] Not steal tasks from same pair, e.g, thread 0 does not steal the task width=2 from thread 1.
            // [EDP] Not steal tasks when ready queue task size is only 1.
            if((st->width >= abs(random_core-nthread)+1)) {
              st = NULL;
              LOCK_RELEASE(worker_lock[random_core]);
              continue;
            }
            else{
              // if(Sched == 2 && DtoA <= maySteal_DtoA){
              //   if(random_core > 1 && nthread < 2){
              //     std::atomic_fetch_sub(&DtoA, 1);
              //   }
              //   else{
              //     if(random_core < 2 && nthread > 1){
              //       if(worker_ready_q[random_core].size() <= 4){
              //         st = NULL;
              //         LOCK_RELEASE(worker_lock[random_core]);
              //         continue;
              //       }
              //       std::atomic_fetch_add(&DtoA, 1);
              //     }
              //   }
              //   //std::cout << "Steal D to A is " << DtoA << "\n";
              // }
              worker_ready_q[random_core].pop_back();
              
// #if (defined ERASE_target_edp_method1)
//               if(ptt_full==true && nthread > 1 && random_core < 2){
//                 if((steal_DtoA++) == D_give_A){
//                   steal_DtoA = 0;
//                 }
//                 st->width = A57_best_edp_width;
//                 if(st->width == 4){
//                   st->leader = 2 + (nthread-2) / st->width;
//                 }
//                 if(st->width <= 2){
//                   st->leader = nthread /st->width * st->width;
//                 }
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] Full PTT: Thread " << nthread << " steal task " << st->taskid << " from " << random_core << " successfully. Task " << st->taskid << " leader is " << st->leader << ", width is " << st->width << std::endl;
//               LOCK_RELEASE(output_lck);          
// #endif	
//               }else{
//                 st->leader = nthread /st->width * st->width;
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] Other: Thread " << nthread << " steal task " << st->taskid << " from " << random_core << " successfully. Task " << st->taskid << " leader is " << st->leader << ", width is " << st->width << std::endl;
//               LOCK_RELEASE(output_lck);          
// #endif	
//               }       
      
// #endif

#if (defined ERASE_target_perf) 
#ifndef MultipleKernels
              // if(ptt_full == true){
                st->history_mold(nthread, st); 
              // }
              // else{
              //   st->eas_width_mold(nthread, st);    
              // }
#endif             
#endif
              if(st->width == 4){
                st->leader = 2 + (nthread-2) / st->width;
              }
              if(st->width <= 2){
                st->leader = nthread /st->width * st->width;
              }
              tao_total_steals++;  
            }
// #ifdef Energyaccuracy
//             if(st->finalenergypred == 0.0f){
//               st->finalenergypred = st->finalpowerpred * st->get_timetable(st->leader, st->width - 1);
// #ifdef DEBUG
//               LOCK_ACQUIRE(output_lck);
//               std::cout << "[DEBUG] Task " << st->taskid << " prediction energy = " << st->finalenergypred << ". \n";
//               LOCK_RELEASE(output_lck);          
// #endif
//             }
// #endif
          }
          else{
            if((Sched == 0) || (Sched == 3)){
            // if((st->criticality == 0 && Sched == 0) ){
              worker_ready_q[random_core].pop_back();
              st->leader = nthread /st->width * st->width;
              tao_total_steals++;
            }else{
              st = NULL;
              LOCK_RELEASE(worker_lock[random_core]);
              continue;
            }
          }

#ifndef CATS				
          if(Sched == 0){
            st->history_mold(nthread, st);    
#ifdef DEBUG
          	LOCK_ACQUIRE(output_lck);
						std::cout << "[DEBUG] Task " << st->taskid << " leader is " << st->leader << ", width is " << st->width << std::endl;
						LOCK_RELEASE(output_lck);
#endif
          }
#endif

#ifdef DEBUG
          LOCK_ACQUIRE(output_lck);
          std::cout << "[DEBUG] Thread " << nthread << " steal task " << st->taskid << " from " << random_core << " successfully. Task " << st->taskid << " leader is " << st->leader << ", width is " << st->width << std::endl;
          LOCK_RELEASE(output_lck);          
#endif	
//           if(Sched == 1){
//             st->eas_width_mold(nthread, st);    
// #ifdef DEBUG
//           	LOCK_ACQUIRE(output_lck);
// 						std::cout << "[EAS-STEAL] Task " << st->taskid << " leader is " << st->leader << ", width is " << st->width << std::endl;
// 						LOCK_RELEASE(output_lck);
// #endif
//           }
          
        }
        LOCK_RELEASE(worker_lock[random_core]);  
      }while(!st && (attempts-- > 0));
      if(st){
#ifdef SLEEP
#if (defined RWSS_SLEEP)
        if(Sched == 3){
          idle_try = 0;
          idle_times = 0;
        }
#endif
#if (defined FCAS_SLEEP)
        if(Sched == 0){
          idle_try = 0;
          idle_times = 0;
        }
#endif
#if (defined EAS_SLEEP)
        if(Sched == 1){
          idle_try = 0;
          idle_times = 0;
        }
#endif
#endif
        status_working[nthread] = 1;
        continue;
      }
    }
#endif
    
/*
    if(Sched == 1){
      if(idle_try >= idle_sleep){
        if(!stop){
			  idle_times++;
        usleep( 100000 * idle_times);
        if(idle_times >= forever_sleep){
          // Step1: disable PTT entries of the thread
          for (int j = 0; j < inclusive_partitions[nthread].size(); ++j){
					  PTT_flag[inclusive_partitions[nthread][j].second - 1][inclusive_partitions[nthread][j].first] = 0;
					  //std::cout << "PTT_flag[" << inclusive_partitions[nthread][j].second - 1 << "]["<<inclusive_partitions[nthread][j].first << "] = 0.\n";
    		  }
          // Step 2: Go back to main work loop to check AQ 
          stop = true;
          continue;
        }
        }
      }
      if(stop){
        // Step 3: Go to sleep forever 
        std::cout << "Thread " << nthread << " go to sleep forever!\n";
        std::unique_lock<std::mutex> lk(m);
        cv.wait(lk, []{return finish;});
        lk.unlock();
        break;
      }
    }
*/
#if (defined SLEEP) 
      if(idle_try >= IDLE_SLEEP){
        long int limit = (SLEEP_LOWERBOUND * pow(2,idle_times) < SLEEP_UPPERBOUND) ? SLEEP_LOWERBOUND * pow(2,idle_times) : SLEEP_UPPERBOUND;  
// #ifdef DEBUG
//         LOCK_ACQUIRE(output_lck);      
//         std::cout << "Thread " << nthread << " sleep for " << limit/1000000 << " ms.\n";
//         LOCK_RELEASE(output_lck);
// #endif
        status[nthread] = 0;
        status_working[nthread] = 0;
        tim.tv_sec = 0;
        tim.tv_nsec = limit;
        nanosleep(&tim , &tim2);
        //SleepNum++;
        AccumTime += limit/1000000;
        idle_times++;
        idle_try = 0;
        status[nthread] = 1;
      }
#endif
    // 4. It may be that there are no more tasks in the flow
    // this condition signals termination of the program
    // First check the number of actual tasks that have completed
//     if(task_completions[nthread].tasks > 0){
//       PolyTask::pending_tasks -= task_completions[nthread].tasks;
// #ifdef DEBUG
//       LOCK_ACQUIRE(output_lck);
//       std::cout << "[DEBUG] Thread " << nthread << " completed " << task_completions[nthread].tasks << " tasks. Pending tasks = " << PolyTask::pending_tasks << "\n";
//       LOCK_RELEASE(output_lck);
// #endif
//       task_completions[nthread].tasks = 0;
//     }
    LOCK_ACQUIRE(worker_lock[nthread]);
    // Next remove any virtual tasks from the per-thread task pool
    if(task_pool[nthread].tasks > 0){
      PolyTask::pending_tasks -= task_pool[nthread].tasks;
#ifdef DEBUG
      LOCK_ACQUIRE(output_lck);
      std::cout << "[DEBUG] Thread " << nthread << " removed " << task_pool[nthread].tasks << " virtual tasks. Pending tasks = " << PolyTask::pending_tasks << "\n";
      LOCK_RELEASE(output_lck);
#endif
      task_pool[nthread].tasks = 0;
    }
    LOCK_RELEASE(worker_lock[nthread]);
    
    // Finally check if the program has terminated
    if(gotao_can_exit && (PolyTask::pending_tasks == 0)){
#ifdef PowerProfiling
      out.close();
#endif
      
#ifdef SLEEP
      LOCK_ACQUIRE(output_lck);
      std::cout << "Thread " << nthread << " sleeps for " << AccumTime << " ms. \n";
      LOCK_RELEASE(output_lck);
#endif

#ifdef PTTaccuracy
      LOCK_ACQUIRE(output_lck);
      std::cout << "Thread " << nthread << " 's MAE = " << MAE << ". \n";
      LOCK_RELEASE(output_lck);
      PTT.close();
#endif

#ifdef Energyaccuracy
      LOCK_ACQUIRE(output_lck);
      std::cout << "Thread " << nthread << " 's Energy Prediction = " << EnergyPrediction << ". \n";
      LOCK_RELEASE(output_lck);
#endif

#ifdef NUMTASKS_MIX
      LOCK_ACQUIRE(output_lck);
// #ifdef TX2
      for(int b = 0;b < gotao_nthreads; b++){
        for(int a = 1; a <= gotao_nthreads; a = a*2){
          std::cout << "Task Type "<< b << ": Thread " << nthread << " with width " << a << " completes " << num_task[b][a * gotao_nthreads + nthread] << " tasks.\n";
          num_task[b][a * gotao_nthreads + nthread] = 0;
        }
      }
      // NUM_WIDTH_TASK[1] += num_task[1 * gotao_nthreads + nthread];
      // NUM_WIDTH_TASK[2] += num_task[2 * gotao_nthreads + nthread];
      // NUM_WIDTH_TASK[4] += num_task[4 * gotao_nthreads + nthread];
      // num_task[1 * gotao_nthreads + nthread] = 0;
      // num_task[2 * gotao_nthreads + nthread] = 0;
      // num_task[4 * gotao_nthreads + nthread] = 0;
// #endif
// #ifdef Haswell
//       // std::cout << "Thread " << nthread << " with width 1 completes " << num_task[1 * gotao_nthreads + nthread] << " tasks.\n";
//       // std::cout << "Thread " << nthread << " with width 2 completes " << num_task[2 * gotao_nthreads + nthread] << " tasks.\n";
//       // std::cout << "Thread " << nthread << " with width 5 completes " << num_task[5 * gotao_nthreads + nthread] << " tasks.\n";
//       // std::cout << "Thread " << nthread << " with width 10 completes " << num_task[10 * gotao_nthreads + nthread] << " tasks.\n";
//       NUM_WIDTH_TASK[1] += num_task[1 * gotao_nthreads + nthread];
//       NUM_WIDTH_TASK[2] += num_task[2 * gotao_nthreads + nthread];
//       NUM_WIDTH_TASK[5] += num_task[5 * gotao_nthreads + nthread];
//       NUM_WIDTH_TASK[10] += num_task[10 * gotao_nthreads + nthread];
//       num_task[1 * gotao_nthreads + nthread] = 0;
//       num_task[2 * gotao_nthreads + nthread] = 0;
//       num_task[5 * gotao_nthreads + nthread] = 0;
//       num_task[10 * gotao_nthreads + nthread] = 0;
// #endif
      LOCK_RELEASE(output_lck);
#endif
#ifdef EXECTIME
      LOCK_ACQUIRE(output_lck);
      std::cout << "The total execution time of thread " << nthread << " is " << elapsed_exe.count() << " s.\n";
      LOCK_RELEASE(output_lck);
#endif
#ifdef OVERHEAD_PTT
      LOCK_ACQUIRE(output_lck);
      std::cout << "PTT overhead of thread " << nthread << " is " << elapsed_ptt.count() << " s.\n";
      LOCK_RELEASE(output_lck);
#endif
      // if(Sched == 0){
      //break;
      // }else{
      return 0;
      // }
    }
  }
//#ifdef PERF_COUNTERS
  // pmc.close();
  // timetask.close();
//#endif
  return 0;
}
