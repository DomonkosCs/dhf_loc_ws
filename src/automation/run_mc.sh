#!/bin/bash

NUM_RUNS=$1
info=$2

# filename in /home/domonkos/dhf_loc_ws/src/dhf_loc_ros/dhf_loc/assets/bags/
bag="5hz_o5e-4_l2e-2"

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argument."
    exit 1
fi

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_medh_bag.launch info:=$info mc:=$i bag:=$bag

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((j=1; j<=NUM_RUNS; j++))
do
    echo "Running launch file - Iteration $j"

    roslaunch dhf_loc dhf_localization_naedh_bag.launch info:=$info mc:=$j bag:=$bag

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

# for ((k=1; k<=NUM_RUNS; k++))
# do
#     echo "Running launch file - Iteration $k"

#     roslaunch dhf_loc dhf_localization_ekf_bag.launch info:=$info mc:=$((k+20)) bag:=$bag

#     while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
#         sleep 1
#     done

# done

# for ((l=1; l<=NUM_RUNS; l++))
# do
#     echo "Running launch file - Iteration $l"

#     roslaunch dhf_loc dhf_localization_amcl_bag.launch info:=$info mc:=$((l+20)) bag:=$bag

#     while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
#         sleep 1
#     done

# done