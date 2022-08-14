/*! @example 
 @brief A program that calculates dotproduct of random two vectors in parallel\n
 we run the example as ./dotprod.out <len> <width> <block> \n
 where
 \param len  := length of vector\n
 \param width := width of TAOs\n
 \param block := how many elements to process per TAO
*/
#include "synthmat.h"
#include "synthcopy.h"
#include "synthstencil.h"
#include <vector>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iomanip>
#include <atomic>
#include <vector>
#include <algorithm>
#include "xitao_api.h"
using namespace xitao;

#ifdef DVFS
float Synth_MatMul::time_table[FREQLEVELS][XITAO_MAXTHREADS][XITAO_MAXTHREADS];
float Synth_MatCopy::time_table[FREQLEVELS][XITAO_MAXTHREADS][XITAO_MAXTHREADS];
float Synth_MatStencil::time_table[FREQLEVELS][XITAO_MAXTHREADS][XITAO_MAXTHREADS];
#else
float Synth_MatMul::time_table[XITAO_MAXTHREADS][XITAO_MAXTHREADS];
float Synth_MatCopy::time_table[XITAO_MAXTHREADS][XITAO_MAXTHREADS];
float Synth_MatStencil::time_table[XITAO_MAXTHREADS][XITAO_MAXTHREADS];
#endif

#if defined(Haswell)
#define MAX_PACKAGES	16
#endif

extern int NUM_WIDTH_TASK[XITAO_MAXTHREADS];

//enum scheduler{PerformanceBased, EnergyAware, EDPAware};
const char *scheduler[] = { "PerformanceBased", "EnergyAware", "EDPAware", "RWSS"/* etc */ };

int main(int argc, char *argv[])
{
  if(argc != 10) {
    std::cout << "./synbench <Scheduler ID> <MM Block Length> <COPY Block Length> <STENCIL Block Length> <Resource Width> <TAO Mul Count> <TAO Copy Count> <TAO Stencil Count> <Degree of Parallelism>" << std::endl; 
    return 0;
  }
#if defined(Haswell)
  char event_names[MAX_PACKAGES][1][256];
	char filenames[MAX_PACKAGES][1][256];
	char basename[MAX_PACKAGES][256];
	char tempfile[256];
	long long before[MAX_PACKAGES][1];
	long long after[MAX_PACKAGES][1];
	int valid[MAX_PACKAGES][1];
	FILE *fff;
#endif

  std::ofstream timetask;
  timetask.open("data_process.sh", std::ios_base::app);

  const int arr_size = 1 << 27;
	//const int arr_size = 1 << 16;
  real_t *A = new real_t[arr_size];
  real_t *B = new real_t[arr_size];
  real_t *C = new real_t[arr_size];
  memset(A, rand(), sizeof(real_t) * arr_size);
  memset(B, rand(), sizeof(real_t) * arr_size);
  memset(C, rand(), sizeof(real_t) * arr_size);

  gotao_init_hw(-1,-1,-1);

  //enum scheduler i;
  //for(int i = PerformanceBased; i <= EnergyAware; i++){
  // for(int i = 0; i < 1; i++){
    //std::cout << "Now the Scheduler is " << scheduler[i] << "\n";
    int schedulerid = atoi(argv[1]);
    int mm_len = atoi(argv[2]);
    int copy_len = atoi(argv[3]);
    int stencil_len = atoi(argv[4]);
    int resource_width = atoi(argv[5]); 
    int tao_mul = atoi(argv[6]);
    int tao_copy = atoi(argv[7]);
    int tao_stencil = atoi(argv[8]);
    int parallelism = atoi(argv[9]);
    int total_taos = tao_mul + tao_copy + tao_stencil;
    int nthreads = XITAO_MAXTHREADS;
    int tao_types = 0;
    //std::cout << "--------- You choose " << scheduler[schedulerid] << " scheduler ---------\n";

    int steal_DtoA = 0;
    int steal_AtoD = 0;
    // if(tao_mul > 0){
    //   float PTT_MatMul_Denver = Synth_MatMul::time_table[0][0];
    //   float PTT_MatMul_A57 = Synth_MatMul::time_table[0][2];
    //   if(i == 2){
    //     if(PTT_MatMul_Denver != 0.0 && PTT_MatMul_A57 != 0.0){
    //       //steal_DtoA = tao_mul * float(PTT_MatMul_Denver*2 / (PTT_MatMul_Denver*2 + PTT_MatMul_A57));
    //       steal_DtoA = tao_mul * float(PTT_MatMul_Denver*(228+2046+2046) / (PTT_MatMul_Denver*(228+2046+2046) + PTT_MatMul_A57*(228+988+809*3)));
    //       steal_AtoD = tao_mul - steal_DtoA;
    //     }
    //   std::cout << "Steal from D to A is " << steal_DtoA << ", steal from A to D is " << steal_AtoD << "\n";
    //   }
    // }
    // if(tao_copy > 0){
    //   float PTT_Copy_Denver = Synth_MatCopy::time_table[0][0];
    //   float PTT_Copy_A57 = Synth_MatCopy::time_table[0][2];
    //   if(i == 2){
    //     if(PTT_Copy_Denver != 0.0 && PTT_Copy_A57 != 0.0){
    //       //steal_DtoA = tao_copy * float(PTT_Copy_Denver*2 / (PTT_Copy_Denver*2 + PTT_Copy_A57));
    //       steal_DtoA = tao_copy * float(PTT_Copy_Denver* (228+228+152) / (PTT_Copy_Denver* (228+228+152) + PTT_Copy_A57 * (228+829+352*3)));
    //       steal_AtoD = tao_copy - steal_DtoA;
    //     }
    //   std::cout << "Steal from D to A is " << steal_DtoA << ", steal from A to D is " << steal_AtoD << "\n";
    //   }
    // }
    
    gotao_init(schedulerid, parallelism, steal_DtoA, steal_AtoD);
    // gotao_init(i, parallelism, steal_DtoA, steal_AtoD);
    
    if(tao_mul > 0){
      tao_types++;
    }
    if(tao_copy > 0){
      tao_types++;
    }
    if(tao_stencil > 0){
      tao_types++;
    }
    //enum scheduler Sched;

    int indx = 0;
    std::ofstream graphfile;
    graphfile.open ("graph.txt");
    graphfile << "digraph DAG{\n";
    
    int current_type = 0;
    int previous_tao_id = 0;
    int current_tao_id = 0;
    AssemblyTask* previous_tao;
    AssemblyTask* startTAO;
    
    
    // create first TAO
    if(tao_mul > 0) {
      previous_tao = new Synth_MatMul(mm_len, resource_width,  A + indx * mm_len * mm_len, B + indx * mm_len * mm_len, C + indx * mm_len * mm_len);
      previous_tao->tasktype = 0;
      previous_tao->kernel_index = 0;
      previous_tao->kernel_name = "MM";
      graphfile << previous_tao_id << "  [fillcolor = lightpink, style = filled];\n";
      tao_mul--;
      indx++;
      if((indx + 1) * mm_len * mm_len > arr_size) indx = 0;
    } else if(tao_copy > 0){
      previous_tao = new Synth_MatCopy(copy_len, resource_width,  A + indx * copy_len * copy_len, B + indx * copy_len * copy_len);
      previous_tao->tasktype = 1;
      previous_tao->kernel_index = 1;
      previous_tao->kernel_name = "CP";
      graphfile << previous_tao_id << "  [fillcolor = skyblue, style = filled];\n";
      tao_copy--;
      indx++;
      if((indx + 1) * copy_len * copy_len > arr_size) indx = 0;
    } else if(tao_stencil > 0) {
      previous_tao = new Synth_MatStencil(stencil_len, resource_width, A+ indx * stencil_len * stencil_len, B+ indx * stencil_len * stencil_len);
      previous_tao->tasktype = 2;
      previous_tao->kernel_index = 2;
      previous_tao->kernel_name = "ST";
      graphfile << previous_tao_id << "  [fillcolor = palegreen, style = filled];\n";
      tao_stencil--;
      indx++;
      if((indx + 1) * stencil_len * stencil_len > arr_size) indx = 0;
    }
    startTAO = previous_tao;
    previous_tao->criticality = 1;
    total_taos--;
    for(int i = 0; i < total_taos; i+=parallelism) {
      AssemblyTask* new_previous_tao;
      int new_previous_id;
#ifdef DVFS
      //for(int j = 0; j < tao_types; j++) {
        AssemblyTask* currentTAO;
        // switch(current_type) {
        //   case 0:
            if(tao_mul > 0) { 
              for(int k = 0; k < parallelism/tao_types; k++){
                currentTAO = new Synth_MatMul(mm_len, resource_width, A + indx * mm_len * mm_len, B + indx * mm_len * mm_len, C + indx * mm_len * mm_len);
                previous_tao->make_edge(currentTAO);  
                currentTAO->tasktype = 0;                               
                graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
                graphfile << current_tao_id << "  [fillcolor = lightpink, style = filled];\n";
                tao_mul--;
                indx++;
                if((indx + 1) * mm_len * mm_len > arr_size) indx = 0;          

                if(k == 0) {
                  new_previous_tao = currentTAO;
                  new_previous_tao->criticality = 1;
                  new_previous_id = current_tao_id;
                }
              }
              // break;
            }
          // case 1: 
            if(tao_copy > 0) {
              //for(int k = parallelism/tao_types; k < parallelism; k++){
              for(int k = 0; k < parallelism/tao_types; k++){
                currentTAO = new Synth_MatCopy(copy_len, resource_width, A + indx * copy_len * copy_len, B + indx * copy_len * copy_len);
                previous_tao->make_edge(currentTAO); 
                currentTAO->tasktype = 1;  
                graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
                graphfile << current_tao_id << "  [fillcolor = skyblue, style = filled];\n";
                tao_copy--;
                indx++;
                if((indx + 1) * copy_len * copy_len > arr_size) indx = 0;     
                if(k == 0) {
                  new_previous_tao = currentTAO;
                  new_previous_tao->criticality = 1;
                  new_previous_id = current_tao_id;
                }         
              }
              // break;
            }
          // case 2: 
            if(tao_stencil > 0) {
              //currentTAO = new Synth_MatStencil(len, resource_width);
              currentTAO = new Synth_MatStencil(stencil_len, resource_width, A+ indx * stencil_len * stencil_len, B+ indx * stencil_len * stencil_len);
              currentTAO->tasktype = 2;  
  /*
              if(indx % 2 == 0){
                //currentTAO = new Synth_MatStencil(stencil_len, resource_width, A+(indx-1)*stencil_len*stencil_len, B+(indx-1)*stencil_len*stencil_len);
                currentTAO = new Synth_MatStencil(stencil_len, resource_width, A, B);
              }else{
                //currentTAO = new Synth_MatStencil(stencil_len, resource_width, B+(indx-1)*stencil_len*stencil_len, A+(indx-1)*stencil_len*stencil_len);
                currentTAO = new Synth_MatStencil(stencil_len, resource_width, B, A);
              }
  */        
              previous_tao->make_edge(currentTAO); 
              graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
              graphfile << current_tao_id << "  [fillcolor = palegreen, style = filled];\n";
              tao_stencil--;
              indx++;
              if((indx + 1) * stencil_len * stencil_len > arr_size) indx = 0;
              break;
            }
          // default:
          //   if(tao_mul > 0) { 
          //     //currentTAO = new Synth_MatMul(len, resource_width);
          //     currentTAO = new Synth_MatMul(mm_len, resource_width, A + indx * mm_len * mm_len, B + indx * mm_len * mm_len, C + indx * mm_len * mm_len);
          //     previous_tao->make_edge(currentTAO); 
          //     graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
          //     graphfile << current_tao_id << "  [fillcolor = lightpink, style = filled];\n";
          //     tao_mul--;
          //     break;
          //   }
        // }
        // if(j == 0) {
        //   new_previous_tao = currentTAO;
        //   new_previous_tao->criticality = 1;
        //   new_previous_id = current_tao_id;
        // }
        current_type++;
        if(current_type >= tao_types) current_type = 0;
      // }
  #else
      for(int j = 0; j < parallelism; ++j) {
        AssemblyTask* currentTAO;
        switch(current_type) {
          case 0:
            if(tao_mul > 0) { 
              //currentTAO = new Synth_MatMul(mm_len, resource_width, A + indx * mm_len * mm_len, B + indx * mm_len * mm_len, C + indx * mm_len * mm_len);
              currentTAO = new Synth_MatMul(mm_len, resource_width, A + mm_len * mm_len, B + mm_len * mm_len, C +mm_len * mm_len);
	      currentTAO->tasktype = 0;
              currentTAO->kernel_index = 0;
	      currentTAO->kernel_name = "MM";
              previous_tao->make_edge(currentTAO);                                 
              graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
              graphfile << current_tao_id << "  [fillcolor = lightpink, style = filled];\n";
              tao_mul--;
              //indx++;
              //if((indx + 1) * mm_len * mm_len > arr_size) indx = 0;
              break;
            }
          case 1: 
            if(tao_copy > 0) {
              currentTAO = new Synth_MatCopy(copy_len, resource_width, A + indx * copy_len * copy_len, B + indx * copy_len * copy_len);
              currentTAO->tasktype = 1;
              currentTAO->kernel_index = 1;
	      currentTAO->kernel_name = "CP";
              previous_tao->make_edge(currentTAO); 
              graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
              graphfile << current_tao_id << "  [fillcolor = skyblue, style = filled];\n";
              tao_copy--;
              indx++;
              if((indx + 1) * copy_len * copy_len > arr_size) indx = 0;
              break;
            }
          case 2: 
            if(tao_stencil > 0) {
              //currentTAO = new Synth_MatStencil(len, resource_width);
              currentTAO = new Synth_MatStencil(stencil_len, resource_width, A+ indx * stencil_len * stencil_len, B+ indx * stencil_len * stencil_len);
  
/*              if(indx % 2 == 1){
                //currentTAO = new Synth_MatStencil(stencil_len, resource_width, A+(indx-1)*stencil_len*stencil_len, B+(indx-1)*stencil_len*stencil_len);
                currentTAO = new Synth_MatStencil(stencil_len, resource_width, A, B);
              }else{
                //currentTAO = new Synth_MatStencil(stencil_len, resource_width, B+(indx-1)*stencil_len*stencil_len, A+(indx-1)*stencil_len*stencil_len);
                currentTAO = new Synth_MatStencil(stencil_len, resource_width, B, A);
              }
*/
              currentTAO->tasktype = 2;        
              currentTAO->kernel_index = 2;
	      currentTAO->kernel_name = "ST";
              previous_tao->make_edge(currentTAO); 
              graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
              graphfile << current_tao_id << "  [fillcolor = palegreen, style = filled];\n";
              tao_stencil--;
              indx++;
              if((indx + 1) * stencil_len * stencil_len > arr_size) indx = 0;
              break;
            }
            
          default:
            if(tao_mul > 0) { 
              //currentTAO = new Synth_MatMul(len, resource_width);
              currentTAO = new Synth_MatMul(mm_len, resource_width, A + indx * mm_len * mm_len, B + indx * mm_len * mm_len, C + indx * mm_len * mm_len);
              currentTAO->tasktype = 0;
              currentTAO->kernel_index = 0;
	      currentTAO->kernel_name = "MM";
              previous_tao->make_edge(currentTAO); 
              graphfile << "  " << previous_tao_id << " -> " << ++current_tao_id << " ;\n";
              graphfile << current_tao_id << "  [fillcolor = lightpink, style = filled];\n";
              tao_mul--;
              break;
            }
        }
//#ifdef Hermes
//        if(j == parallelism/2-1) 
//#else
        if(j == parallelism-1) 
//#endif
        {      
          new_previous_tao = currentTAO;
          new_previous_tao->criticality = 1;
          new_previous_id = current_tao_id;
        }
        current_type++;
        if(current_type >= tao_types) current_type = 0;
      }
  #endif
      previous_tao = new_previous_tao;
      previous_tao_id = new_previous_id;
    }
    //close the output
    graphfile << "}";
    graphfile.close();
    gotao_push(startTAO, 0);
    std::chrono::time_point<std::chrono::system_clock> start, end;
    start = std::chrono::system_clock::now();
    auto start1_ms = std::chrono::time_point_cast<std::chrono::milliseconds>(start);
    auto epoch1 = start1_ms.time_since_epoch();

#if defined(Haswell)
    int iii,jjj = 0; 
    for(jjj=0;jjj<NUMSOCKETS;jjj++) {
      iii = 0;
      std::cout << "Check Point 1\n";
      sprintf(basename[jjj],"/sys/class/powercap/intel-rapl/intel-rapl:%d",jjj);
      std::cout << "basename[" << jjj << "]: " << basename[jjj] << std::endl;
      sprintf(tempfile,"%s/name",basename[jjj]);
      fff=fopen(tempfile,"r");
      if (fff==NULL) {
        fprintf(stderr,"\tCould not open %s\n",tempfile);
        return -1;
      }
      std::cout << "Check Point 2\n";
      fscanf(fff,"%s",event_names[jjj][iii]);
      std::cout << "event_names[" << jjj << "][" << iii << "]: " << event_names[jjj][iii] << std::endl;
      std::cout << "Check Point 3\n";
      valid[jjj][iii]=1;
      fclose(fff);
      sprintf(filenames[jjj][iii],"%s/energy_uj",basename[jjj]);
      
     /* Handle subdomains */
      for(iii=1;iii<1;iii++) {
        sprintf(tempfile,"%s/intel-rapl:%d:%d/name",
          basename[jjj],jjj,iii-1);
        fff=fopen(tempfile,"r");
        if (fff==NULL) {
          //fprintf(stderr,"\tCould not open %s\n",tempfile);
          valid[jjj][iii]=0;
          continue;
        }
        valid[jjj][iii]=1;
        fscanf (fff,"%s",event_names[jjj][iii]);
        fclose(fff);
        sprintf(filenames[jjj][iii],"%s/intel-rapl:%d:%d/energy_uj", basename[jjj],jjj,iii-1);
      }
    }
    // Gather before values 
    iii = 0;
    for(jjj=0;jjj<NUMSOCKETS;jjj++) {
      if (valid[jjj][iii]) {
        fff=fopen(filenames[jjj][iii],"r");
        if (fff==NULL) {
          fprintf(stderr,"\tError opening %s!\n",filenames[jjj][iii]);
        }
        else {
          fscanf(fff,"%lld",&before[jjj][iii]);
          fclose(fff);
        }
      }
      std::cout << "Before[" << jjj << "][" << iii << "]: " << before[jjj][iii] << std::endl;
    }
#endif
    goTAO_start();
    goTAO_fini();

#if defined(Haswell)
    // Gather after values 
    iii = 0;
    for(jjj=0;jjj < NUMSOCKETS;jjj++) {
      if (valid[jjj][iii]) {
        fff=fopen(filenames[jjj][iii],"r");
        if (fff==NULL) {
          fprintf(stderr,"\tError opening %s!\n",filenames[jjj][iii]);
        }
        else {
          fscanf(fff,"%lld",&after[jjj][iii]);
          fclose(fff);
        }
      }
      std::cout << "after[" << jjj << "][" << iii << "]: " << after[jjj][iii] << std::endl;
    }

    // for(jjj=0;jjj < NUMSOCKETS;jjj++) {
    //   printf("\tPackage %d\n",jjj);
    //     if (valid[jjj][iii]) {
    //       printf("\t\t%s\t: %lfJ\n",event_names[jjj][iii], ((double)after[jjj][iii]-(double)before[jjj][iii])/1000000.0);
    //     }
    // }
#endif
  end = std::chrono::system_clock::now();
  auto end1_ms = std::chrono::time_point_cast<std::chrono::milliseconds>(end);
  auto epoch1_end = end1_ms.time_since_epoch();
  std::chrono::duration<double> elapsed_seconds = end-start;
  timetask << "python Energy.py " << epoch1.count() << "\t" <<  epoch1_end.count() << "\n";
  timetask.close();
/*  
#if (defined NUMTASKS) & (defined Haswell)
  std::cout << NUM_WIDTH_TASK[1] << " tasks complete with width 1. \n";
  std::cout << NUM_WIDTH_TASK[2]/2 << " tasks complete with width 2. \n";
  std::cout << NUM_WIDTH_TASK[5]/5 << " tasks complete with width 5. \n";
  std::cout << NUM_WIDTH_TASK[10]/10 << " tasks complete with width 10. \n";
#endif
*/
// #if (defined NUMTASKS) & (defined TX2)
//   std::cout << NUM_WIDTH_TASK[1] << " tasks complete with width 1. \n";
//   std::cout << NUM_WIDTH_TASK[2]/2 << " tasks complete with width 2. \n";
//   std::cout << NUM_WIDTH_TASK[4]/4 << " tasks complete with width 4. \n";
// #endif

  //  if(i < 3){
  // Synth_MatMul::print_ptt(Synth_MatMul::time_table, "MatMul");
  
    //if(tao_copy > 0){
      // Synth_MatCopy::print_ptt(Synth_MatCopy::time_table, "MatCopy");
    //}
    // if(tao_stencil > 0){
      // Synth_MatStencil::print_ptt(Synth_MatStencil::time_table, "MatStencil", 0);
    // }
  // }

// #if defined(CRIT_PERF_SCHED)  
  //xitao_ptt::print_ptt<Synth_MatMul>("MatMul");
//   xitao_ptt::print_ptt<Synth_MatCopy>("MaCopy");
  // xitao_ptt::print_ptt<Synth_MatStencil>("MatStencil");
// #endif
 //std::cout << total_taos + 1 << "," << parallelism << "," << epoch1.count() << "\t" <<  epoch1_end.count() << "," << elapsed_seconds.count() << "," << (total_taos+1) / elapsed_seconds.count() << "\n";
  //std::cout << elapsed_seconds.count() << std::endl;

#ifdef Haswell  
  std::cout << total_taos + 1 << "," << parallelism << "," << elapsed_seconds.count() << "," \
   << (((double)after[0][0]-(double)before[0][0])+((double)after[1][0]-(double)before[1][0]))/1000000.0 << \
   ((double)after[0][0]-(double)before[0][0])/1000000.0 << ", " << ((double)after[1][0]-(double)before[1][0])/1000000.0 << "\n";
#endif
 
//    std::cout << "\n\n";
//  for(int aa = 0; aa < XITAO_MAXTHREADS; aa++){
//    if(exec_time[aa] != 0){
//        std::cout << elapsed_seconds.count() - exec_time[aa] << "\n";
//    }
//  }
  // }
  //std::cout << total_taos + 1 <<" Tasks completed in "<< elapsed_seconds.count() << "s\n";
  //std::cout << "Assembly Throughput: " << (total_taos) / elapsed_seconds.count() << " A/sec\n"; 
  //std::cout << "Total number of steals: " <<  tao_total_steals << "\n";
}
