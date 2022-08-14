#!/bin/bash
frequency="1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"
export XITAO_LAYOUT_PATH=./ptt_layout_a1
for freq in $frequency
do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    sleep 5
    for((k=0;k<3;k++))
    do
        echo "/*-----------------------STEER Scheduler $k th Begin! Fibonacci | Freq: ${freq} -----------------------*/"
        ./benchmarks/fibonacci/fibonacci 3 1 55 34 > ./benchmarks/fibonacci/fib_steer_${freq}_${k}.txt
        sleep 5
        echo "/*-----------------------STEER Scheduler $k th End! Fibonacci | Freq: ${freq} -----------------------*/"
    done
done
#     echo $freq
#     echo "D_1: "
#     export XITAO_LAYOUT_PATH=./ptt_layout_d1; ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 1 0 200 0 1
#     echo "D_2: "
#     export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 2 0 200 0 1
#     echo "A_1: "
#     export XITAO_LAYOUT_PATH=./ptt_layout_a1; ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 1 0 200 0 1
#     echo "A_2: "
#     export XITAO_LAYOUT_PATH=./ptt_layout_a2; ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 2 0 200 0 1
#     echo "A_4: "
#     export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 0 8192 0 4 0 200 0 1
#     sleep 5


# export XITAO_LAYOUT_PATH=./ptt_layout_tx2

# --- Fibonacci ---
# for((k=0;k<5;k++))
# do
#     # 3 = RWS, 0 = {CATS, CALC}, width = 1, block length = 320000, 200 blocks = 200 tasks, 100 iterations ==> 20000 tasks in total 
#     echo "/*-----------------------D1 Scheduler $k th Begin! Fibonacci -----------------------*/"
#     ./benchmarks/fibonacci/fibonacci 3 1 55 34 > ./benchmarks/fibonacci/fib_d1_${k}.txt
#     # A57=0 DENVER=1 ./benchmarks/dotproduct/cats 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_cats_${k}.txt
#     # A57=1 DENVER=1 ./benchmarks/dotproduct/dotprod 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_calc_${k}.txt
#     # A57=0 DENVER=0 ./benchmarks/dotproduct/dotprod 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_erase_${k}.txt
#     # A57=0 DENVER=1 ./benchmarks/dotproduct/erase 3 100 64000000 2 320000 > ./benchmarks/dotproduct/dotprod_erase_d2_${k}.txt
#     sleep 5
#     echo "/*-----------------------D1 Scheduler $k th End! Fibonacci -----------------------*/"
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_d2
# for((k=0;k<5;k++))
# do
#     A57=0 DENVER=1 ./benchmarks/fibonacci/erase 3 55 34 > ./benchmarks/fibonacci/fib_erase_d2_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_d1
# for((k=0;k<5;k++))
# do
#     A57=0 DENVER=1 ./benchmarks/fibonacci/erase 3 55 34 > ./benchmarks/fibonacci/fib_erase_d1_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a4
# for((k=0;k<3;k++))
# do
#     A57=0 DENVER=1 ./benchmarks/fibonacci/erase 3 55 34 > ./benchmarks/fibonacci/fib_erase_a4_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a1
# for((k=0;k<3;k++))
# do
#     A57=1 DENVER=1 ./benchmarks/fibonacci/erase 3 55 34 > ./benchmarks/fibonacci/fib_erase_a1_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_d2
# # --- Dot Product ---
# for((k=0;k<5;k++))
# do
#     # 3 = RWS, 0 = {CATS, CALC}, width = 1, block length = 320000, 200 blocks = 200 tasks, 100 iterations ==> 20000 tasks in total 
#     # A57=0 DENVER=1 ./benchmarks/dotproduct/rws 3 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_rws_${k}.txt
#     # A57=0 DENVER=1 ./benchmarks/dotproduct/cats 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_cats_${k}.txt
#     # A57=1 DENVER=1 ./benchmarks/dotproduct/dotprod 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_calc_${k}.txt
#     # A57=0 DENVER=0 ./benchmarks/dotproduct/dotprod 0 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_erase_${k}.txt
#     A57=0 DENVER=1 ./benchmarks/dotproduct/erase 3 100 64000000 2 320000 > ./benchmarks/dotproduct/dotprod_erase_d2_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_d1
# for((k=0;k<5;k++))
# do
#     A57=0 DENVER=1 ./benchmarks/dotproduct/erase 3 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_erase_d1_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a4
# for((k=0;k<3;k++))
# do
#     A57=0 DENVER=1 ./benchmarks/dotproduct/erase 3 100 64000000 4 320000 > ./benchmarks/dotproduct/dotprod_erase_a4_${k}.txt
#     sleep 2
# done

# export XITAO_LAYOUT_PATH=./ptt_layout_a1
# for((k=0;k<3;k++))
# do
#     A57=1 DENVER=1 ./benchmarks/dotproduct/erase 3 100 64000000 1 320000 > ./benchmarks/dotproduct/dotprod_erase_a1_${k}.txt
#     sleep 2
# done

