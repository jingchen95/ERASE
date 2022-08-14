#!/bin/bash
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

emc_frequency="1866000000 1600000000 1331200000 1062400000 800000000"
# 665600000 408000000 204000000 102000000 68000000 40800000
cpu_frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"

# emc_frequency="1866000000"
# cpu_frequency="2035200 1881600 1113600"

# Test
# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" 
#   # sleep 5
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/"
#     # sleep 5
#     jetson_clocks --show 
#     sleep 5 
#     for((k=0;k<1;k++))
#     do
#       echo "/*----------------------- MM	100.00%	+	MC	0.00% - Denver_1: $k th Begin! -----------------------*/" 
#       export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 2000 0 0 1 >> Test_A57_4.txt
#       sleep 5
#     done
#   done
# done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	100.00%	+	MC	0.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 2000 0 0 1 >> ./A57_4/MM100_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	97.50%	+	MC	2.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1950 12 0 1 >> ./A57_4/MM97_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	95.00%	+	MC	5.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1900 24 0 1 >> ./A57_4/MM95_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	92.50%	+	MC	7.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1850 36 0 1 >> ./A57_4/MM92_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	90.00%	+	MC	10.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1800 48 0 1 >> ./A57_4/MM90_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	87.50%	+	MC	12.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1750 60 0 1 >> ./A57_4/MM87_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	85.00%	+	MC	15.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1700 72 0 1 >> ./A57_4/MM85_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	82.50%	+	MC	17.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1650 84 0 1 >> ./A57_4/MM82_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	80.00%	+	MC	20.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1600 96 0 1 >> ./A57_4/MM80_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	77.50%	+	MC	22.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1550 108 0 1 >> ./A57_4/MM77_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	75.00%	+	MC	25.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1500 120 0 1 >> ./A57_4/MM75_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	72.50%	+	MC	27.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1450 131 0 1 >> ./A57_4/MM72_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	70.00%	+	MC	30.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1400 143 0 1 >> ./A57_4/MM70_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	67.50%	+	MC	32.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1350 155 0 1 >> ./A57_4/MM67_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	65.00%	+	MC	35.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1300 167 0 1 >> ./A57_4/MM65_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	62.50%	+	MC	37.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1250 179 0 1 >> ./A57_4/MM62_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	60.00%	+	MC	40.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1200 191 0 1 >> ./A57_4/MM60_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	57.50%	+	MC	42.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1150 203 0 1 >> ./A57_4/MM57_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	55.00%	+	MC	45.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1100 215 0 1 >> ./A57_4/MM55_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	52.50%	+	MC	47.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1050 227 0 1 >> ./A57_4/MM52_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	50.00%	+	MC	50.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 1000 239 0 1 >> ./A57_4/MM50_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	47.50%	+	MC	52.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 950 251 0 1 >> ./A57_4/MM47_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	45.00%	+	MC	55.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 900 263 0 1 >> ./A57_4/MM45_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	42.50%	+	MC	57.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 850 275 0 1 >> ./A57_4/MM42_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	40.00%	+	MC	60.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 800 287 0 1 >> ./A57_4/MM40_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	37.50%	+	MC	62.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 750 299 0 1 >> ./A57_4/MM37_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	35.00%	+	MC	65.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 700 311 0 1 >> ./A57_4/MM35_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	32.50%	+	MC	67.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 650 323 0 1 >> ./A57_4/MM32_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	30.00%	+	MC	70.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 600 335 0 1 >> ./A57_4/MM30_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	27.50%	+	MC	72.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 550 347 0 1 >> ./A57_4/MM27_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	25.00%	+	MC	75.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 500 359 0 1 >> ./A57_4/MM25_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	22.50%	+	MC	77.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 450 370 0 1 >> ./A57_4/MM22_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	20.00%	+	MC	80.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 400 382 0 1 >> ./A57_4/MM20_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	17.50%	+	MC	82.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 350 394 0 1 >> ./A57_4/MM17_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	15.00%	+	MC	85.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 300 406 0 1 >> ./A57_4/MM15_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	12.50%	+	MC	87.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 250 418 0 1 >> ./A57_4/MM12_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	10.00%	+	MC	90.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 200 430 0 1 >> ./A57_4/MM10_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	7.50%	+	MC	92.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 150 442 0 1 >> ./A57_4/MM7_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	5.00%	+	MC	95.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 100 454 0 1 >> ./A57_4/MM5_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 5
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 5
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	2.50%	+	MC	97.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 50 466 0 1 >> ./A57_4/MM2_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<1;k++))
    do
      echo "/*----------------------- MM	0.00%	+	MC	100.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 4 0 478 0 1 >> ./A57_4/MM0_${emcfreq}_${freq}.txt
      sleep 5
    done
  done
done