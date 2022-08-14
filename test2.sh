#!/bin/bash
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

emc_frequency="1866000000"
cpu_frequency="2035200 1113600"
for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/"
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" 
    sleep 2
    jetson_clocks --show
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	100.00%	+	MC	0.00% - Denver_1: $k th Begin! -----------------------*/"
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 2000 0 0 1 > Test_A57_4_${emcfreq}_${freq}_${k}.txt
      sleep 2
    done
  done
done
