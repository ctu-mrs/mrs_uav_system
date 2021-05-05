#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

echo "Starting automated ROS test of the mrs_workspace"

source /opt/ros/$ROS_DISTRO/setup.bash
source ~/mrs_workspace/devel/setup.bash

export UAV_NAME=uav1
export RUN_TYPE="simulation" # {simulation, uav}
export UAV_TYPE="t650" # {f550, f450, t650, eagle, naki}
export PROPULSION_TYPE="default" # {default, new_esc, ...}
export ODOMETRY_TYPE="gps" # {gps, optflow, hector, vio, ...}
export SENSORS="garmin_down" # {gps, optflow, hector, vio, ...}
export ROS_MASTER_URI=http://localhost:11311

roscore &

sleep 2

cd ~/mrs_workspace

catkin build mrs_uav_testing # it has to be fully build normally before building with --catkin-make-args tests
catkin build mrs_uav_testing --catkin-make-args tests
TEST_RESULT_PATH=$(realpath /tmp/$RANDOM)
mkdir -p $TEST_RESULT_PATH
rostest --reuse-master mrs_uav_testing control_test_rostest.launch -t --results-filename=mrs_uav_testing.test --results-base-dir="$TEST_RESULT_PATH"
catkin_test_results "$TEST_RESULT_PATH"

echo "Tests finished"
