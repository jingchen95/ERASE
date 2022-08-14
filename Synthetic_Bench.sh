#!/bin/bash
rm data_process.sh PMC.txt nohup.out Synthetic_MB_A57_1.txt Process.txt

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

# emc_frequency="1600000000"
# 1600000000 1331200000 1062400000 800000000 665600000 408000000 204000000 102000000 68000000 40800000"
# cpu_frequency="1267200 1113600 960000 806400 652800 499200 345600"
#  2035200 1881600 1728000 1574400 1420800

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (Balance) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1000 667 0 1 >> Synthetic_MB_A57_1.txt # Perfect balance between MM and MC (22s each)
#       # export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 8192 0 1 1000 175 0 1
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+5%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1028 621 0 1 >> Synthetic_MB_A57_1.txt # (22s * 1.05) / 0.02246 = 1028 iterations MM; (22s * 0.95) / 0.03365 = 621 iterations MC
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+10%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1077 588 0 1 >> Synthetic_MB_A57_1.txt # (22s * 1.1) / 0.02246 = 1077 iterations MM; (22s * 0.9) / 0.03365 = 588 iterations MC
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+15%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1126 556 0 1 >> Synthetic_MB_A57_1.txt # (22s * 1.15) / 0.02246 = 1126 iterations MM; (22s * 0.85) / 0.03365 = 556 iterations MC
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+20%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1175 523 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+25%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1224 490 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

emc_frequency="1600000000"
# 1600000000 1331200000 1062400000 800000000 665600000 408000000 204000000 102000000 68000000 40800000"
cpu_frequency="652800 499200 345600"
#  2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 

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
      echo "/*----------------------- MM+MC Mix (+30%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1273 458 0 1 >> Synthetic_MB_A57_1.txt
      sleep 2
    done
  done
done

emc_frequency="1600000000"
cpu_frequency="1267200 1113600 960000 806400 652800 499200 345600"

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
      echo "/*----------------------- MM+MC Mix (+35%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1322 425 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+40%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1371 392 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+45%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1420 360 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+50%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1469 327 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+55%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1518 294 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+60%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1567 262 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+65%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1616 229 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+70%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1665 196 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+75%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1714 163 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+80%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1763 131 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+85%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1812 98 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+90%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1861 65 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+95%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1910 33 0 1 >> Synthetic_MB_A57_1.txt
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
      echo "/*----------------------- MM+MC Mix (+100%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 1959 0 0 1 >> Synthetic_MB_A57_1.txt
      sleep 2
    done
  done
done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       # ------------- memory copy increasing iterations --------------
#       echo "/*----------------------- MM+MC Mix (+5%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 931 686 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+10%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 882 719  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+15%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 833 752  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+20%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 784 785 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+25%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 735 817 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+30%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 686 850  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+35%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 637	883 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+40%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 588	915  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+45%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 539 948  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+50%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 490 981  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+55%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 441	1013  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+60%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 392 1046 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+65%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 343 1079  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+70%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 294 1111 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+75%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 245 1144  0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+80%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 196 1177 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+85%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 147 1210 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+90%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 98 1242 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+95%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 49 1275 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

# for emcfreq in $emc_frequency
# do
#   echo 1 >/sys/kernel/debug/bpmp/debug/clk/emc/mrq_rate_locked
#   echo $emcfreq > /sys/kernel/debug/bpmp/debug/clk/emc/rate
#   echo 1 > /sys/kernel/debug/bpmp/debug/clk/emc/state
#   echo "/*----------------------- Changing DDR frequency to ${emcfreq} -----------------------*/" >> Process.txt
#   sleep 2
#   for freq in $cpu_frequency
#   do
#     echo $freq  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#     echo $freq  > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
#     echo "/*----------------------- Changing A57 + Denver frequency to ${freq} -----------------------*/" >> Process.txt
#     sleep 2
#     jetson_clocks --show >> Process.txt
#     sleep 2 
#     for((k=0;k<3;k++))
#     do
#       echo "/*----------------------- MM+MC Mix (+100%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
#       export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 0 1308 0 1 >> Synthetic_MB_A57_1.txt
#       sleep 2
#     done
#   done
# done

emc_frequency="1062400000"
# 1600000000 1331200000 1062400000 800000000 665600000 408000000 204000000 102000000 68000000 40800000"
cpu_frequency="499200 345600"
#  2035200 1881600 1728000 1574400 1420800 1267200 1113600 960000 806400 652800 

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
      echo "/*----------------------- MM+MC Mix (MC+85%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 147 1210 0 1 >> Synthetic_MB_A57_1.txt
      sleep 2
    done
  done
done

emc_frequency="800000000"
# 1600000000 1331200000 1062400000 800000000 665600000 408000000 204000000 102000000 68000000 40800000"
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
      echo "/*----------------------- MM+MC Mix (MC+85%) - A57_1: $k th Begin! -----------------------*/" >> Process.txt
      export XITAO_LAYOUT_PATH=./a1; ./benchmarks/syntheticDAGs/synbench 3 128 4096 0 1 147 1210 0 1 >> Synthetic_MB_A57_1.txt
      sleep 2
    done
  done
done