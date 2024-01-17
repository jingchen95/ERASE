#!/bin/bash
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

emc_frequency="1866000000 1600000000 1331200000 1062400000 800000000"
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	100.00%	+	MC	0.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 4000 0 0 1 > ./Denver_2/MM100_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	97.50%	+	MC	2.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3900 32 0 1 > ./Denver_2/MM97_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	95.00%	+	MC	5.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3800 63 0 1 > ./Denver_2/MM95_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	92.50%	+	MC	7.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3700 95 0 1 > ./Denver_2/MM92_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	90.00%	+	MC	10.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3600 126 0 1 > ./Denver_2/MM90_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	87.50%	+	MC	12.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3500 158 0 1 > ./Denver_2/MM87_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	85.00%	+	MC	15.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3400 189 0 1 > ./Denver_2/MM85_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	82.50%	+	MC	17.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3300 221 0 1 > ./Denver_2/MM82_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	80.00%	+	MC	20.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3200 252 0 1 > ./Denver_2/MM80_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	77.50%	+	MC	22.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3100 284 0 1 > ./Denver_2/MM77_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	75.00%	+	MC	25.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 3000 315 0 1 > ./Denver_2/MM75_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	72.50%	+	MC	27.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2900 347 0 1 > ./Denver_2/MM72_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	70.00%	+	MC	30.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2800 378 0 1 > ./Denver_2/MM70_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	67.50%	+	MC	32.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2700 410 0 1 > ./Denver_2/MM67_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	65.00%	+	MC	35.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2600 441 0 1 > ./Denver_2/MM65_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	62.50%	+	MC	37.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2500 473 0 1 > ./Denver_2/MM62_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	60.00%	+	MC	40.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2400 504 0 1 > ./Denver_2/MM60_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	57.50%	+	MC	42.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2300 536 0 1 > ./Denver_2/MM57_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	55.00%	+	MC	45.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2200 567 0 1 > ./Denver_2/MM55_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	52.50%	+	MC	47.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2100 599 0 1 > ./Denver_2/MM52_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	50.00%	+	MC	50.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 2000 630 0 1 > ./Denver_2/MM50_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	47.50%	+	MC	52.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1900 662 0 1 > ./Denver_2/MM47_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	45.00%	+	MC	55.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1800 693 0 1 > ./Denver_2/MM45_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	42.50%	+	MC	57.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1700 725 0 1 > ./Denver_2/MM42_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	40.00%	+	MC	60.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1600 756 0 1 > ./Denver_2/MM40_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	37.50%	+	MC	62.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1500 788 0 1 > ./Denver_2/MM37_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	35.00%	+	MC	65.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1400 819 0 1 > ./Denver_2/MM35_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	32.50%	+	MC	67.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1300 851 0 1 > ./Denver_2/MM32_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	30.00%	+	MC	70.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1200 882 0 1 > ./Denver_2/MM30_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	27.50%	+	MC	72.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1100 914 0 1 > ./Denver_2/MM27_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	25.00%	+	MC	75.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 1000 945 0 1 > ./Denver_2/MM25_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	22.50%	+	MC	77.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 900 977 0 1 > ./Denver_2/MM22_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	20.00%	+	MC	80.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 800 1008 0 1 > ./Denver_2/MM20_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	17.50%	+	MC	82.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 700 1040 0 1 > ./Denver_2/MM17_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	15.00%	+	MC	85.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 600 1071 0 1 > ./Denver_2/MM15_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	12.50%	+	MC	87.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 500 1103 0 1 > ./Denver_2/MM12_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	10.00%	+	MC	90.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 400 1134 0 1 > ./Denver_2/MM10_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	7.50%	+	MC	92.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 300 1166 0 1 > ./Denver_2/MM7_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	5.00%	+	MC	95.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 200 1197 0 1 > ./Denver_2/MM5_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	2.50%	+	MC	97.50% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 100 1229 0 1 > ./Denver_2/MM2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<2;k++))
    do
      echo "/*----------------------- MM	0.00%	+	MC	100.00% - Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 2 0 1260 0 1 > ./Denver_2/MM0_${emcfreq}_${freq}_${k}.txt
      sleep 2
    done
  done
done