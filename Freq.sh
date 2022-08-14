#!/bin/bash
export XITAO_LAYOUT_PATH=./ptt_layout_test

Frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"
TaskSize="256"

for((k=0;k<5;k++))
do
for size in $TaskSize
do
  for freq in $Frequency
  do
	  echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
	  echo $freq > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
	  sleep 1
    ./benchmarks/syntheticDAGs/synbench 3 0 0 $size 1 0 0 5000 1
    sleep 1
  done
done
done
