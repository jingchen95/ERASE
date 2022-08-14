#!/bin/bash

# ERASE Test
# Flag: PERF_COUNTERS + DynaDVFS
# export XITAO_LAYOUT_PATH=./ptt_layout_tx2
# DENVER=0 A57=0 ./benchmarks/syntheticDAGs/synbench 1 128 0 0 1 10000 0 0 4 > test.txt & 
# # a=$(($RANDOM%8+3))
# a=6
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+5))
# a=11
# echo "Frequency = 345600 khz: $a seconds"
# echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+3))
# a=3
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+5))
# a=5
# echo "Frequency = 345600 khz: $a seconds"
# echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+3))
# a=10
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+5))
# a=7
# echo "Frequency = 345600 khz: $a seconds"
# echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# # a=$(($RANDOM%8+3))
# a=5
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=4
# echo "Frequency = 345600 khz: $a seconds"
# echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=8
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=11
# echo "Frequency = 345600 khz: $a seconds"
# echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=3
# echo "Frequency = 2035200 khz: $a seconds"
# echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a


# ideal case:
export XITAO_LAYOUT_PATH=./ptt_layout_test

./benchmarks/syntheticDAGs/synbench 3 128 0 0 2 30000 0 0 4 &
a=6
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+5))
a=11
echo "Frequency = 345600 khz: $a seconds"
echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+3))
a=3
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+5))
a=5
echo "Frequency = 345600 khz: $a seconds"
echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+3))
a=10
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+5))
a=7
echo "Frequency = 345600 khz: $a seconds"
echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
# a=$(($RANDOM%8+3))
a=5
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
a=4
echo "Frequency = 345600 khz: $a seconds"
echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
a=8
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
a=11
echo "Frequency = 345600 khz: $a seconds"
echo 345600  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 345600  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
a=3
echo "Frequency = 2035200 khz: $a seconds"
echo 2035200  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed; echo 2035200  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed & sleep $a
