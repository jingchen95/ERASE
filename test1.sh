#!/bin/bash
export XITAO_LAYOUT_PATH=./ptt_layout_a4
Frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"
#Frequency="2035200 1113600"

for((k=0;k<1;k++))
do
	for freq in $Frequency
	do
		echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
		echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
		sleep 2
  		./benchmarks/syntheticDAGs/synbench 3 0 2048 0 4 0 2000 0 1
		sleep 2
	done
done
