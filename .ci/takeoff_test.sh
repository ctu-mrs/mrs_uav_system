#!/bin/bash

echo "Starting takeoff test" 
cd ~/catkin_ws
source /opt/ros/melodic/setup.bash

catkin run_tests mrs_uav_testing

catkin_test_results ~/catkin_ws/build/mrs_uav_testing
