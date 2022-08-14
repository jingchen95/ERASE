#!/bin/bash
export XITAO_LAYOUT_PATH=./ptt_layout_test
ff=2
gg=1

# Set the envrionment
#echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 2035200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#echo 345600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

echo "/*----------------------------------------------*/"
#echo "Random Work Stealing Scheduler Begin! "
#echo ""
for((j=$ff;j>0;j--))
do
  for((i=$gg;i<=1;i+=2))
  do
    echo "Freq = 2035200 - Parallelism = $i:"
    ./benchmarks/syntheticDAGs/synbench 3 64 4096 64 1 1000 0 0 $i 
    sleep 2
    echo ""
  done
done

ff=2
gg=1
echo 1574400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
for((j=$ff;j>0;j--))
do
  for((i=$gg;i<=1;i+=2))
  do
    echo "Freq = 1574400 - Parallelism = $i:"
    ./benchmarks/syntheticDAGs/synbench 3 64 4096 64 1 1000 0 0 $i
    sleep 2
    echo ""
  done
done

ff=2
gg=1
echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
for((j=$ff;j>0;j--))
do
  for((i=$gg;i<=1;i+=2))
  do
    echo "Freq = 1113600 - Parallelism = $i:"
    ./benchmarks/syntheticDAGs/synbench 3 64 4096 64 1 1000 0 0 $i
    sleep 2
    echo ""
  done
done

ff=2
gg=1
echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
for((j=$ff;j>0;j--))
do
  for((i=$gg;i<=1;i+=2))
  do
    echo "Freq = 652800 - Parallelism = $i:"
    ./benchmarks/syntheticDAGs/synbench 3 64 4096 64 1 1000 0 0 $i
    sleep 2
    echo ""
  done
done

ff=2
gg=1
echo 345600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
for((j=$ff;j>0;j--))
do
  for((i=$gg;i<=1;i+=2))
  do
    echo "Freq = 345600 - Parallelism = $i:"
    ./benchmarks/syntheticDAGs/synbench 3 64 4096 64 1 1000 0 0 $i
    sleep 2
    echo ""
  done
done
#echo "Random Work Stealing Scheduler Finish! "
#echo "/*----------------------------------------------*/"
#echo ""
#echo ""

#echo "/*----------------------------------------------*/"
#echo "Energy Aware Scheduler Begin! "
#echo ""
#for((j=$ff;j>0;j--))
#do
#  A57=0 DENVER=0 ./benchmarks/alya-xitao/EAS ./benchmarks/alya-xitao/C200K.csr
#  echo ""
#done
#echo "Energy Aware Scheduler Finish! "
#echo "/*----------------------------------------------*/"

# Python script requires high frequency for visualizing power curve
#echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
