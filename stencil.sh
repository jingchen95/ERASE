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
  for freq in $cpu_frequency
  do
    echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
    echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
    echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
    jetson_clocks --show >> Process.txt
    sleep 5 
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MatrixCopy_A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 0 10240 0 1 0 100 0 1 >> ./Test/MatrixCopy_10240_A57_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MatrixCopy_A57_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a2; ./benchmarks/syntheticDAGs/synbench 3 0 10240 0 2 0 100 0 1 >> ./Test/MatrixCopy_10240_A57_2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MatrixCopy_A57_4: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 0 10240 0 4 0 100 0 1 >> ./Test/MatrixCopy_10240_A57_4_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MatrixCopy_Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 0 10240 0 1 0 100 0 1 >> ./Test/MatrixCopy_10240_Denver_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- MatrixCopy_Denver_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 0 10240 0 2 0 100 0 1 >> ./Test/MatrixCopy_10240_Denver_2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- Stencil_A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 1 0 0 100 1 >> ./Test/stencil_2048_A57_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- Stencil_A57_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a2; ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 2 0 0 100 1 >> ./Test/stencil_2048_A57_2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- Stencil_A57_4: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 4 0 0 100 1 >> ./Test/stencil_2048_A57_4_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- Stencil_Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 1 0 0 100 1 >> ./Test/stencil_2048_Denver_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- Stencil_Denver_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 0 0 2048 2 0 0 100 1 >> ./Test/stencil_2048_Denver_2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- matmul_A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 2048 0 0 1 1 0 0 1 >> ./Test/matmul_2048_A57_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- matmul_A57_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a2; ./benchmarks/syntheticDAGs/synbench 3 2048 0 0 2 1 0 0 1 >> ./Test/matmul_2048_A57_2_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- matmul_A57_4: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_a4; ./benchmarks/syntheticDAGs/synbench 3 2048 0 0 4 1 0 0 1 >> ./Test/matmul_2048_A57_4_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- matmul_Denver_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./d1; ./benchmarks/syntheticDAGs/synbench 3 2048 0 0 1 1 0 0 1 >> ./Test/matmul_2048_Denver_1_${emcfreq}_${freq}_${k}.txt
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
    for((k=0;k<3;k++))
    do
      echo "/*----------------------- matmul_Denver_2: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./ptt_layout_d2; ./benchmarks/syntheticDAGs/synbench 3 2048 0 0 2 1 0 0 1 >> ./Test/matmul_2048_Denver_2_${emcfreq}_${freq}_${k}.txt
      sleep 5
    done
  done
done

