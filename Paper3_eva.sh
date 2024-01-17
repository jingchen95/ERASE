#!/bin/bash

# --- Dot Product ---
emc_frequency="800000000"
cpu_frequency="1574400 1420800 1267200 1113600 960000"
# 2035200 1881600 1728000 
#  806400 652800 499200 345600
for emcfreq in $emc_frequency
do
    echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
    echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
    echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
    for freq in $cpu_frequency
    do
        echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
        echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
        sleep 5
        for((k=0;k<1;k++))
        do
            echo "/*----------------------- ERASE Scheduler Begin! fibonacci - $emcfreq - $freq -----------------------*/"
            echo " "
            export XITAO_LAYOUT_PATH=./ptt_layout_a1; ./benchmarks/fibonacci/fibonacci 3 1 55 34 > ./debug_results/fib_a1_${emcfreq}_${freq}.txt
            sleep 5
            echo "/*----------------------The $emcfreq - $freq finish!-----------------------*/"
        done
    done
done

# for((k=0;k<5;k++))
# do
#     echo "/*----------------------- GRWS Scheduler Begin! Dot Product -----------------------*/"
#     echo " "
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/dotproduct/dotprod 3 1000 40000000 1 200000 > ./debug_results/dotprod_20k_GRWS_$k.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     echo "/*----------------------- ERASE Scheduler Begin! Dot Product -----------------------*/"
#     echo " "
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/dotproduct/dotprod 1 1000 40000000 1 200000 > ./debug_results/dotprod_20k_ERASE_$k.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<5;k++))
# do
#     echo "/*----------------------- GRWS Scheduler Begin! Dot Product -----------------------*/"
#     echo " "
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/dotproduct/dotprod 3 1000 40000000 1 1000000 > ./debug_results/dotprod_100k_GRWS_$k.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     echo "/*----------------------- ERASE Scheduler Begin! Dot Product -----------------------*/"
#     echo " "
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/dotproduct/dotprod 1 1000 40000000 1 1000000 > ./debug_results/dotprod_100k_ERASE_$k.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done



# --- Heat ---
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! 2D Heat- small  -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 3 ./benchmarks/heat/small.dat > ./debug_results/heat_small_grws_${k}.txt 
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------ERASE Scheduler Begin! 2D Heat- small -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 1 ./benchmarks/heat/small.dat > ./debug_results/heat_small_erase_${k}.txt # ERASE
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! 2D Heat- big -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 3 ./benchmarks/heat/big.dat > ./debug_results/heat_big_grws_${k}.txt 
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------ERASE Scheduler Begin! 2D Heat- big  -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 1 ./benchmarks/heat/big.dat > ./debug_results/heat_big_erase_${k}.txt # ERASE
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! 2D Heat- huge  -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 3 ./benchmarks/heat/huge.dat > ./debug_results/heat_huge_grws_${k}.txt 
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------ERASE Scheduler Begin! 2D Heat - huge -----------------------*/"
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/heat/heat-tao 1 ./benchmarks/heat/huge.dat > ./debug_results/heat_huge_erase_${k}.txt # ERASE
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# --- Sparse LU : enable Multiple kernel ---
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Sparse LU-----------------------*/"
#     echo " "
#     # [1] GRWS 
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 3 32 256 > ./debug_results/sparselu_grws_32_256_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 3 32 512 > ./debug_results/sparselu_grws_32_512_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 3 64 256 > ./debug_results/sparselu_grws_64_256_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 3 64 512 > ./debug_results/sparselu_grws_64_512_${k}.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# for((k=0;k<10;k++))
# do
#     # [2] ERASE
#     echo "/*-----------------------ERASE Scheduler Begin! Sparse LU-----------------------*/"
#     echo " "
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 1 32 256 > ./debug_results/sparselu_erase_32_256_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 1 32 512 > ./debug_results/sparselu_erase_32_512_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 1 64 256 > ./debug_results/sparselu_erase_64_256_${k}.txt
#     sleep 5
#     export XITAO_LAYOUT_PATH=./ptt_layout_tx2; ./benchmarks/sparselu/sparselu 1 64 512 > ./debug_results/sparselu_erase_64_512_${k}.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# parallelism="4"
# cpu_frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"
# emc_frequency="1866000000 1600000000 1331200000 1062400000 800000000"

# # on 2 Denver
# export XITAO_LAYOUT_PATH=./ptt_layout_d2
# for dop in $parallelism
# do
#     for emcfreq in $emc_frequency
#     do
#         echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#         echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#         echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#         echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#         sleep 2
#         for freq in $cpu_frequency
#         do
#             echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#             echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#             echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#             sleep 2
#             jetson_clocks --show >> Process.txt
#             sleep 2 
#             for((k=0;k<2;k++))
#             do
#                 echo "/*----------------------- CP - 4096 - 200 - 2D - p${dop} - $k iteration starts! -----------------------*/" >> Process.txt
#                 ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 2 0 200 0 $dop >> ./debug_results/cp_4096_2D_p${dop}.txt
#                 # jetson_clocks --show >> ./debug_results/cp_1024_2D_p${dop}_${k}.txt
#                 sleep 2
#             done
#         done
#     done
# done

# # on 1 Denver
# export XITAO_LAYOUT_PATH=./ptt_layout_d1
# for dop in $parallelism
# do
#     for emcfreq in $emc_frequency
#     do
#         echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#         echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#         echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#         echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#         sleep 2
#         for freq in $cpu_frequency
#         do
#             echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#             echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#             echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#             sleep 2
#             jetson_clocks --show >> Process.txt
#             sleep 2 
#             for((k=0;k<2;k++))
#             do
#             echo "/*----------------------- CP - 4096 - 200 - 1D - p${dop} - $k iteration starts! -----------------------*/" >> Process.txt
#             ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 1 0 200 0 $dop >> ./debug_results/cp_4096_1D_p${dop}.txt
#             # jetson_clocks --show >> ./debug_results/cp_1024_1D_p${dop}_${k}.txt
#             sleep 2
#             done
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a1
# for dop in $parallelism
# do
#     for emcfreq in $emc_frequency
#     do
#         echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#         echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#         echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#         echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#         sleep 2
#         for freq in $cpu_frequency
#         do
#             echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#             echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#             echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#             sleep 2
#             jetson_clocks --show >> Process.txt
#             sleep 2 
#             for((k=0;k<2;k++))
#             do
#             echo "/*----------------------- CP -  4096 - 200 - 1A - p${dop} - $k iteration starts! -----------------------*/" >> Process.txt
#             ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 1 0 200 0 $dop >> ./debug_results/cp_4096_1A_p${dop}.txt
#             # jetson_clocks --show >> ./debug_results/cp_1024_1A_p${dop}_${k}.txt
#             sleep 2
#             done
#         done
#     done
# done


# export XITAO_LAYOUT_PATH=./ptt_layout_a2
# for dop in $parallelism
# do
#     for emcfreq in $emc_frequency
#     do
#         echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#         echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#         echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#         echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#         sleep 2
#         for freq in $cpu_frequency
#         do
#             echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#             echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#             echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#             sleep 2
#             jetson_clocks --show >> Process.txt
#             sleep 2 
#             for((k=0;k<2;k++))
#             do
#             echo "/*----------------------- CP - 4096 - 200  - 2A - p${dop} - $k iteration starts! -----------------------*/" >> Process.txt
#             ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 2 0 200 0 $dop >> ./debug_results/cp_4096_2A_p${dop}.txt
#             # jetson_clocks --show >> ./debug_results/cp_1024_2A_p${dop}_${k}.txt
#             sleep 2
#             done
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a4
# for dop in $parallelism
# do
#     for emcfreq in $emc_frequency
#     do
#         echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#         echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#         echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#         echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#         sleep 2
#         for freq in $cpu_frequency
#         do
#             echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#             echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#             echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#             sleep 2
#             jetson_clocks --show >> Process.txt
#             sleep 2 
#             for((k=0;k<2;k++))
#             do
#                 echo "/*----------------------- CP - 4096 - 200  - 4 A- p${dop} - $k iteration starts! -----------------------*/" >> Process.txt
#                 ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 4 0 200 0 $dop >> ./debug_results/cp_4096_4A_p${dop}.txt
#                 # jetson_clocks --show >> ./debug_results/cp_1024_4A_p${dop}_${k}.txt
#                 sleep 2
#             done
#         done
#     done
# done

# --- Synthetic DAGs ---

# -------------- GRWS ---------------- #
# MatMul
# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! MatMul, 256, 10k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 256 0 0 1 10000 0 0 $dop > ./Paper3_results/mm_256_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! MatMul, 512, 2k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 512 0 0 1 2000 0 0 $dop > ./Paper3_results/mm_512_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# # Stencil
# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Stencil, 512, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 0 512 1 0 0 50000 $dop > ./Paper3_results/st_512_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Stencil, 1024, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 1 0 0 50000 $dop > ./Paper3_results/st_1024_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Stencil, 2048, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 1 0 0 50000 $dop > ./Paper3_results/st_2048_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# # Memory Copy
# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 1024, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 1024 0 1 0 50000 0 $dop > ./Paper3_results/cp_1024_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 2048, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 2048 0 1 0 50000 0 $dop > ./Paper3_results/cp_2048_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 4096, 20k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 4096 0 1 0 20000 0 $dop > ./Paper3_results/cp_4096_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 8192, 10k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 1 0 10000 0 $dop > ./Paper3_results/cp_8192_GRWS_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# -------------- ERASE ---------------- #
# MatMul
# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! MatMul, 256, 10k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 256 0 0 1 10000 0 0 $dop > ./Paper3_results/mm_256_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! MatMul, 512, 2k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 512 0 0 1 2000 0 0 $dop > ./Paper3_results/mm_512_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# Stencil
# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! Stencil, 512, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 0 512 1 0 0 50000 $dop > ./Paper3_results/st_512_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! Stencil, 1024, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 0 1024 1 0 0 50000 $dop > ./Paper3_results/st_1024_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done
# parallelism="16"
# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! Stencil, 2048, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 0 2048 1 0 0 50000 $dop > ./Paper3_results/st_2048_ERASE_p${dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# Memory Copy
# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! COPY, 1024, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 1024 0 1 0 50000 0 $dop > ./Paper3_results/cp_1024_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! COPY, 2048, 50k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 2048 0 1 0 50000 0 $dop > ./Paper3_results/cp_2048_ERASE_p{$dop}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! COPY, 4096, 20k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<3;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 4096 0 1 0 20000 0 $dop > ./Paper3_results/cp_4096_ERASE_p{$dop}_$k.txt
#         sleep 5
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for dop in $parallelism
# do
#     echo "/*-----------------------ERASE Scheduler Begin! COPY, 8192, 10k, Parallelism = $dop-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 1 0 8192 0 1 0 10000 0 $dop > ./Paper3_results/cp_8192_ERASE_p{$dop}_$k.txt
#         sleep 5
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done