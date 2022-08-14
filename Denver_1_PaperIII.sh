#!/bin/bash
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

emc_frequency="1866000000 1600000000 1331200000 1062400000 800000000"
# 665600000 408000000 204000000 102000000 68000000 40800000
cpu_frequency="2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 499200 345600"

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	100.00%	+	MC	0.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 2000 0 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	97.50%	+	MC	2.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1950 27 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	95.00%	+	MC	5.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1900 53 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	92.50%	+	MC	7.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1850 80 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	90.00%	+	MC	10.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1800 107 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	87.50%	+	MC	12.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1750 133 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	85.00%	+	MC	15.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1700 160 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	82.50%	+	MC	17.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1650 187 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	80.00%	+	MC	20.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1600 213 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	77.50%	+	MC	22.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1550 240 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	75.00%	+	MC	25.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1500 267 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	72.50%	+	MC	27.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1450 293 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	70.00%	+	MC	30.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1400 320 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	67.50%	+	MC	32.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1350 346 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	65.00%	+	MC	35.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1300 373 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	62.50%	+	MC	37.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1250 400 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	60.00%	+	MC	40.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1200 426 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	57.50%	+	MC	42.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1150 453 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	55.00%	+	MC	45.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1100 480 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	52.50%	+	MC	47.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1050 506 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	50.00%	+	MC	50.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1000 533 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	47.50%	+	MC	52.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 950 560 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	45.00%	+	MC	55.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 900 586 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	42.50%	+	MC	57.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 850 613 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	40.00%	+	MC	60.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 800 640 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	37.50%	+	MC	62.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 750 666 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	35.00%	+	MC	65.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 700 693 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	32.50%	+	MC	67.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 650 720 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	30.00%	+	MC	70.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 600 746 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	27.50%	+	MC	72.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 550 773 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	25.00%	+	MC	75.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 500 800 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	22.50%	+	MC	77.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 450 826 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	20.00%	+	MC	80.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 400 853 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	17.50%	+	MC	82.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 350 879 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	15.00%	+	MC	85.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 300 906 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	12.50%	+	MC	87.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 250 933 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	10.00%	+	MC	90.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 200 959 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	7.50%	+	MC	92.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 150 986 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	5.00%	+	MC	95.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 100 1013 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	2.50%	+	MC	97.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 50 1039 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done

for emcfreq in $emc_frequency
do
  echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
  echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
  echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
  echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
  sleep 2
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    sleep 2
    jetson_clocks --show >> Process.txt
    sleep 2 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MM	0.00%	+	MC	100.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 0 1066 0 1 >> Synthetic_MB_Denver_1.txt
      sleep 2
    done
  done
done