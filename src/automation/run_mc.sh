#!/bin/bash

NUM_RUNS=$1
info=$2

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argumend."
    exit 1
fi

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_edh_bag.launch info:=$info mc:=$i

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((j=1; j<=NUM_RUNS; j++))
do
    echo "Running launch file - Iteration $j"

    roslaunch dhf_loc dhf_localization_ekf_bag.launch info:=$info mc:=$j

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((k=1; k<=NUM_RUNS; k++))
do
    echo "Running launch file - Iteration $k"

    roslaunch dhf_loc dhf_localization_amcl_bag.launch info:=$info mc:=$k

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done