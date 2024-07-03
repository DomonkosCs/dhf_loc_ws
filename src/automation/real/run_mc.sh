#!/bin/bash

NUM_RUNS=$1
info=$2

bag="bme_map_take"

if [ -z "$NUM_RUNS" ]; then
    echo "Please provide the number of runs as a command-line argument."
    exit 1
fi

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "EKF: Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_bmemap_rtk_ekf.launch info:=$info mc:=$i bag:=$bag

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "MEDH: Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_bmemap_rtk.launch info:=$info mc:=$i bag:=$bag filter:=medh

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "NAEDH: Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_bmemap_rtk.launch info:=$info mc:=$i bag:=$bag filter:=naedh

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "AMCL: Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_bmemap_rtk_amcl.launch info:=$info mc:=$i bag:=$bag

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done

for ((i=1; i<=NUM_RUNS; i++))
do
    echo "AMCLP: Running launch file - Iteration $i"

    roslaunch dhf_loc dhf_localization_bmemap_rtk_amclp.launch info:=$info mc:=$i bag:=$bag

    while [$(rosnode list | grep '/rosbag' | wc -l) -ne 0 ]; do
        sleep 1
    done

done