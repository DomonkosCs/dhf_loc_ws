#!/bin/bash

NUM_RUNS=$1
info=$2

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argument."
    exit 1
fi

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_amcl_bag.launch mc:=$i info:=$info

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

