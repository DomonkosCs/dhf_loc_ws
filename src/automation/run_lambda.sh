#!/bin/bash

NUM_RUNS=$1
LAMBDAS=(3 4 5 7 10 15 25)
info=$3

# filename in /home/domonkos/dhf_loc_ws/src/dhf_loc_ros/dhf_loc/assets/bags/
bag="5hz_o5e-4_l2e-2"

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argumeny."
    exit 1
fi

for lambda in "${LAMBDAS[@]}"; do
    for ((i=1; i<=NUM_RUNS; i++))
    do
        echo "Running launch file - Iteration $i"

        roslaunch dhf_loc dhf_localization_medh_bag.launch info:=$info mc:=$i lambda_num:=$lambda bag:=$bag

        while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
            sleep 1
        done

    done

    for ((i=1; i<=NUM_RUNS; i++))
    do
        echo "Running launch file - Iteration $i"

        roslaunch dhf_loc dhf_localization_naedh_bag.launch info:=$info mc:=$i lambda_num:=$lambda bag:=$bag

        while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
            sleep 1
        done

    done
done