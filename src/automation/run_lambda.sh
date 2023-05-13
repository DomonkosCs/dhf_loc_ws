#!/bin/bash

NUM_RUNS=$1
LAMBDA=$2
info=$3

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argumend."
    exit 1
fi

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_medh_bag.launch info:=$info mc:=$i lambda_number:=$LAMBDA

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_naedh_bag.launch info:=$info mc:=$i lambda_number:=$LAMBDA

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

