#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

echo "Starting takeoff test" 

source /opt/ros/$ROS_DISTRO/setup.bash
source ~/mrs_workspace/devel/setup.bash

export UAV_NAME=uav1
export RUN_TYPE="simulation" # {simulation, uav}
export UAV_TYPE="t650" # {f550, f450, t650, eagle, naki}
export PROPULSION_TYPE="default" # {default, new_esc, ...}
export ODOMETRY_TYPE="gps" # {gps, optflow, hector, vio, ...}

cd ~/mrs_workspace

catkin run_tests mrs_uav_testing

catkin_test_results ~/mrs_workspace/build/mrs_uav_testing
