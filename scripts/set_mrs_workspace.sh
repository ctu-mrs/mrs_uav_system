#!/bin/bash
# author: Tomas Baca

# create the directory for the workspace
mkdir -p ~/$ROS_WORKSPACE/src

cd ~/$ROS_WORKSPACE

catkin config --profile debug --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color' -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin profile set reldeb

# link uav_core repository to mrs_workspace
cd src
ln -s ~/git/uav_core

#############################################
# Compile the workspace for the first time
#############################################

cd ~/$ROS_WORKSPACE
source /opt/ros/melodic/setup.bash
# command catkin build mavros --mem-limit 75%
command catkin build -c --mem-limit 75%

# # after sucessfully building mavros, install libgeo
# cd ~/git/uav_core/ros_packages/mavros/mavros/scripts
# sudo ./install_geographiclib_datasets.sh
