#!/bin/bash

echo "Starting takeoff test" 
source ~/.bashrc

cd ~/mrs_workspace

catkin run_tests mrs_uav_testing

catkin_test_results ~/mrs_workspace/build/mrs_uav_testing
