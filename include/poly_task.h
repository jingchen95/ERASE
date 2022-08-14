/*! \file 
@brief Defines the basic PolyTask type
*/

#ifndef _POLY_TASK_H
#define _POLY_TASK_H
#include <list>
#include <atomic>
#include <string>
#include "config.h"
#include "lfq-fifo.h"
#include "xitao_workspace.h"
#include "xitao_ptt.h"
extern int a57_freq;
extern int denver_freq;

/*! the basic PolyTask type */
class PolyTask {
public:
  // PolyTasks can have affinity. Currently these are specified on a unidimensional vector
  // space [0,1) of type float. [0,1) are valid affinities, >=1.0 means no affinity
  float affinity_relative_index; 
  // this is the particular queue. When cloning an affinity, we just copy this value
  int   affinity_queue;          
//#if defined(CRIT_PERF_SCHED)
  //Static atomic of current most critical task for criticality-based scheduling
  static std::atomic<int> prev_top_task;     
  //int criticality;
  int marker;
//#endif

  // New code because of running heat
  // A pointer to the corresponding ptt table
  xitao::ptt_shared_type _ptt;  
  // An integer descriptor to distinguish the workload of several TAOs of the same type
  // it is mainly used by the scheduler when picking up the correct PTT
  size_t workload_hint;

  // An string type for indentification of different kernel tasks
  std::string kernel_name;
  int kernel_index;
  int type;
  int tasktype;
  // The leader task id in the resource partition
  int leader;
  int criticality;
  int taskid;
  int updateflag;
#ifdef PTTaccuracy
  float finalpredtime;
#endif
#ifdef Energyaccuracy
  float finalenergypred;
  float finalpowerpred;
#endif
#if defined(DEBUG)
  static std::atomic<int> created_tasks;
#endif
  static std::atomic<int> pending_tasks;
  
  std::atomic<int> refcount;
  std::list <PolyTask *> out;
  std::atomic<int> threads_out_tao;
  int width; /*!< number of resources that this assembly uses */  

  //Virtual declaration of performance table get/set within tasks
// #if defined(TX2)
//   virtual float get_power(int thread, int real_core_use, int real_use_bywidth) = 0;
// #endif

// #if defined(Haswell)
//   virtual float Haswell_Dyna_power(int thread, int width) = 0;
// #endif

// #if defined(DVFS)
//   virtual float get_timetable(int env, int thread, int index) = 0;
//   virtual void set_timetable(int env, int thread, float t, int index) = 0;
// #else
  virtual float get_timetable(int thread, int index) = 0;
  virtual void set_timetable(int thread, float t, int index) = 0;
// #endif

  //History-based molding
  virtual int history_mold(int _nthread, PolyTask *it);
  //Recursive function assigning criticality
  int set_criticality();
  int set_marker(int i);
  //Determine if task is critical task
  int if_prio(int _nthread, PolyTask * it);

  virtual int ERASE_Target_Perf(int nthread, PolyTask * it);
  virtual int ERASE_Target_EDP(int nthread, PolyTask * it);
  virtual int ERASE_Target_Energy(int nthread, PolyTask * it);
  virtual int ERASE_Target_Energy_2(int nthread, PolyTask * it);

  virtual int globalsearch_Perf(int nthread, PolyTask * it);
  virtual int eas_width_mold(int nthread, PolyTask * it);
// #ifdef DVFS
//   static void print_ptt(float table[][XITAO_MAXTHREADS][XITAO_MAXTHREADS], const char* table_name);
// #else
  static void print_ptt(float table[][XITAO_MAXTHREADS], const char* table_name);
// #endif
  //Find suitable thread for prio task
  PolyTask(int t, int _nthread);
  
  //! Convert from an STA to an actual queue number
  /*!
    \param x a floating point value between [0, 1) that indicates the topology address in one dimension
  */
  int sta_to_queue(float x);
  //! give a TAO an STA address
  /*!
    \param x a floating point value between [0, 1) that indicates the topology address in one dimension
  */
  int set_sta(float x);
  //! get the current STA address of a TAO
  float get_sta();
  //! copy the STA of a TAO to the current TAO
  int clone_sta(PolyTask *pt);
  //! create a dependency to another TAO
  /*!
    \param t a TAO with which a happens-before order needs to be ensured (TAO t should execute after *this) 
  */
  void make_edge(PolyTask *t);
  
  //! complete the current TAO and wake up all dependent TAOs
  /*!
    \param _nthread id of the current thread
  */
#ifdef OVERHEAD_PTT
  PolyTask * commit_and_wakeup(int _nthread,  std::chrono::duration<double> elapsed_ptt);
#else
  PolyTask * commit_and_wakeup(int _nthread);
#endif
  
  //! cleanup any dynamic memory that the TAO may have allocated
  virtual void cleanup() = 0;
};
#endif