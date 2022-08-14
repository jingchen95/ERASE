#!/bin/bash

# rm PMC.txt
export XITAO_LAYOUT_PATH=./ptt_layout_d2
frequency="1881600 1728000 1574400 1420800 1267200 960000 806400 652800 499200 345600"
# MatMul  
for freq in $frequency
do
    echo "/*-----------------------Sparse LU - Accuracy Test: frequency: $freq-----------------------*/"
    echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    sleep 1
    for((i=8;i<9;i+=2)) #parallelism
    do
        for((k=0;k<1;k++))
        do
            # ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 2 0 0 1000 $i > ./d2/st_2048_${freq}_d2.txt
            ./benchmarks/sparselu/sparselu 3 32 256 >> test.txt
            mv PMC.txt PMC_${freq}_d2.txt
            sleep 2
        done
    done
    echo "/*-----------------------The $freq try finish!-----------------------*/"
done

# export XITAO_LAYOUT_PATH=./ptt_layout_d1
# frequency="1881600 1728000 1574400 1420800 1267200 960000 806400 652800 499200 345600"
# for freq in $frequency
# do
#     echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     sleep 1
#     for((i=8;i<9;i+=2)) #parallelism
#     do
#         echo "/*-----------------------GRWS Scheduler Begin! Copy, 1024, 100 tasks, accuracy test, Parallelism = $i-----------------------*/"
#         echo " "
#         for((k=0;k<1;k++))
#         do
#             ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 1 0 0 1000 $i > ./d1/st_2048_${freq}_d1.txt
#             mv PMC.txt PMC_${freq}_d1.txt
#             sleep 2
#             echo "/*-----------------------The $k th try finish!-----------------------*/"
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a4
# frequency="1881600 1728000 1574400 1420800 1267200 960000 806400 652800 499200 345600"
# # frequency="345600"
# for freq in $frequency
# do
#     echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     sleep 1
#     for((i=8;i<9;i+=2)) #parallelism
#     do
#         echo "/*-----------------------GRWS Scheduler Begin! Copy, 1024, 100 tasks, accuracy test, Parallelism = $i-----------------------*/"
#         echo " "
#         for((k=0;k<1;k++))
#         do
#             ./benchmarks/syntheticDAGs/synbench 3  0 0 1024  4 0 0 1000 $i > ./a4/cp_2048_${freq}_a4.txt
#             mv PMC.txt PMC_${freq}_a4.txt
#             sleep 2
#             echo "/*-----------------------The $k th try finish!-----------------------*/"
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a2
# frequency="1881600 1728000 1574400 1420800 1267200 960000 806400 652800 499200 345600"
# for freq in $frequency
# do
#     echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     sleep 1
#     for((i=8;i<9;i+=2)) #parallelism
#     do
#         echo "/*-----------------------GRWS Scheduler Begin! Copy, 1024, 100 tasks, accuracy test, Parallelism = $i-----------------------*/"
#         echo " "
#         for((k=0;k<1;k++))
#         do
#             ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 2 0 0 1000 $i > ./a2/cp_2048_${freq}_a2.txt
#             mv PMC.txt PMC_${freq}_a2.txt
#             sleep 2
#             echo "/*-----------------------The $k th try finish!-----------------------*/"
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a1
# frequency="1881600 1728000 1574400 1420800 1267200 960000 806400 652800 499200 345600"
# for freq in $frequency
# do
#     echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     sleep 1
#     for((i=8;i<9;i+=2)) #parallelism
#     do
#         echo "/*-----------------------GRWS Scheduler Begin! Copy, 1024, 100 tasks, accuracy test, Parallelism = $i-----------------------*/"
#         echo " "
#         for((k=0;k<1;k++))
#         do
#             ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 1 0 0 1000 $i > ./a1/cp_2048_${freq}_a1.txt
#             mv PMC.txt PMC_${freq}_a1.txt
#             sleep 2
#             echo "/*-----------------------The $k th try finish!-----------------------*/"
#         done
#     done
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_tx2

# --- Heat ---
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------ERASE Scheduler Begin! 2D Heat -----------------------*/"
#     # ./benchmarks/heat/heat-tao 3 ./benchmarks/heat/small.dat > heat_grws_${k}.txt # GRWS
#     # ./benchmarks/heat/heat-tao 1 ./benchmarks/heat/small.dat > heat_erase_${k}.txt # ERASE
#     ./benchmarks/heat/grws 3 ./benchmarks/heat/big.dat > heat_grws_${k}.txt # ERASE
#     sleep 5
#     ./benchmarks/heat/erase 1 ./benchmarks/heat/big.dat > heat_erase_${k}.txt # ERASE
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a1
# --- Dot Product ---
# frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"
# frequency="1113600"
# for freq in $frequency
# do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     sleep 5
#     for((k=0;k<5;k++))
#     do
#         echo "/*-----------------------GRWS Scheduler Begin! Dot Product, cur freq $freq -----------------------*/"
#         echo " "
#         ./benchmarks/dotproduct/dotprod 3 100 64000000 1 320000 > dotprod_a1_${freq}_$k.txt
#         sleep 5
#         echo "/*----------------------The $k th try finish!-----------------------*/"
#     done
# done

# --- Sparse LU : enable Multiple kernel ---
# for((k=0;k<10;k++))
# do
#     echo "/*-----------------------ERASE Scheduler Begin! Sparse LU-----------------------*/"
#     echo " "
    # [1] GRWS 
    # ./benchmarks/sparselu/sparselu 3 32 256 > ./sparselu_grws_32_256_${k}.txt
    # ./benchmarks/sparselu/sparselu 3 32 512 > ./sparselu_grws_32_512_${k}.txt
    # ./benchmarks/sparselu/sparselu 3 64 256 > ./sparselu_grws_64_256_${k}.txt
    # ./benchmarks/sparselu/sparselu 3 64 512 > ./sparselu_grws_64_512_${k}.txt
    # [2] ERASE
    # # ./benchmarks/sparselu/sparselu 1 32 256 > ./sparselu_erase_32_256_${k}.txt
    # ./benchmarks/sparselu/sparselu 1 32 512 > ./sparselu_erase_32_512_${k}.txt
    # ./benchmarks/sparselu/sparselu 1 64 256 > ./sparselu_erase_64_256_${k}.txt
    # ./benchmarks/sparselu/sparselu 1 64 512 > ./sparselu_erase_64_512_${k}.txt
#     sleep 5
#     echo "/*----------------------The $k th try finish!-----------------------*/"
# done

# MatMul
# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! MatMul, 64, 50k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 64 0 0 1 50000 0 0 $i > mm_64_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! MatMul, 256, 10k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 256 0 0 1 10000 0 0 $i > mm_256_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# Copy
# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 1024, 50k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 1024 0 1 0 50000 0 $i > cp_1024_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! COPY, 2048, 50k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 2048 0 1 0 50000 0 $i > cp_2048_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# Stencil
# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Stencil, 512, 50k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 0 512 1 0 0 50000 $i > st_512_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done

# for((i=4;i<9;i+=2))
# do
#     echo "/*-----------------------GRWS Scheduler Begin! Stencil, 1024, 50k, Parallelism = $i-----------------------*/"
#     echo " "
#     for((k=0;k<5;k++))
#     do
#         ./benchmarks/syntheticDAGs/synbench 3 0 0 1024 1 0 0 50000 $i > st_1024_GRWS_p{$i}_$k.txt
#         sleep 2
#         echo "/*-----------------------The $k th try finish!-----------------------*/"
#     done
# done
