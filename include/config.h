#ifndef _CONFIG_H
#define _CONFIG_H

/* Open debug option*/
//#define DEBUG

//#define PARALLEL_CHAINS /* Parallel chains */

/* Power Model for Hebbe in Synthetic DAG Benchmarks */
// #define Haswell
// #define NUMSOCKETS 2
// #define COREPERSOCKET 10

// Power Profiling Kernel tasks, especially for applications with multiple kernels
//#define PowerProfiling

// xitao_api.h => alya TAO
//#define ALYA

// A test of threshold for fine-grained task detection in STEER
//#define STEER_TH_ANALYSIS
//#define STEER_AVERAGE
//#define STEER_HIGH
//#define STEER_LOW

/* Power Model for TX2 in Synthetic DAG Benchmarks */
#define TX2

/* Average same configuration */
#define AveCluster

/* Set different ERASE target (only one is allowed) */
//#define ERASE_target_perf
//#define ERASE_target_energy_method1
#define ERASE_target_energy_method2

/* Blancing EDP between Denver and A57 clusters */
// #define ERASE_target_edp_method1

/* Test if energy increase (cost) is lower than execution time reduction (benefit) */
//#define ERASE_target_edp_method2

/* Test if energy optimization can use the same method as EDP */
//#define ERASE_target_test

/* Performance Counters - calculate IPC */
//#define PERF_COUNTERS

/* Check the PTT Accuracy between prediction and real time*/
//#define PTTaccuracy

/* Check the accuracy between the energy prediction and real energy */
//#define Energyaccuracy
/* If application has multiple kernels, can not use single ptt_full (sparseLU test)*/
//#define MultipleKernels


/* ERASE uses second energy efficient config - to compare the energy with most energy efficent one*/
//#define second_efficient

//#define CATA
//#define Hermes

// #define DVFS
#define TASKTYPES 2 // MM+CP
// #define FREQLEVELS 2
#define NUMSOCKETS 2
//#define EAS_PTT_TRAIN 3
/* Frequency setting: 0=>MAX, 1=>MIN */
#define A57 0
#define DENVER 0

#define STEAL_ATTEMPTS 1

/* Idle sleep try */
#define IDLE_SLEEP 100
/*Sleep time bound settings (nanoseconds)*/
#define SLEEP_LOWERBOUND 1000000
#define SLEEP_UPPERBOUND 64000000

/* Schedulers with sleep for idle work stealing loop */
#define SLEEP

/* Random working stealing with sleep */
#define RWSS_SLEEP

/* Performance-oriented with sleep */
//#define FCAS_SLEEP
//#define CRI_COST
//#define CRI_PERF

// CATS Scheduler
//#define CATS

/* Energy aware scheduler */
#define EAS_SLEEP
#define EAS_NoCriticality

// #define ACCURACY_TEST

/* Enable or disable work stealing */
#define WORK_STEALING

/* Accumulte the total exec time this thread complete */
#define EXECTIME

/* Accumulte the number of task this thread complete */
//#define NUMTASKS_MIX

/* Accumulte the PTT visiting time */
// #define OVERHEAD_PTT

// #define ONLYCRITICAL

// #define PARA_TEST

//#define NEED_BARRIER

//#define DynaDVFS

#define GOTAO_THREAD_BASE 0
#define GOTAO_NO_AFFINITY (1.0)
#define TASK_POOL 100
#define TAO_STA 1
#define XITAO_MAXTHREADS 6
#define L1_W   1
#define L2_W   2
#define L3_W   6
////#define L4_W   12
////#define L5_W   48
#define TOPOLOGY { L1_W, L2_W}
#define GOTAO_HW_CONTEXTS 1

//Defines for hetero environment if Weight or Crit_Hetero scheduling
//#define LITTLE_INDEX 0
//#define LITTLE_NTHREADS 4
//#define BIG_INDEX 4
//#define BIG_NTHREADS 4

//#define KMEANS
#endif
