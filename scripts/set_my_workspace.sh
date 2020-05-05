#!/bin/bash
# author: Tomas Baca

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

MY_WORKSPACE=workspace

# create the folder structure
mkdir -p ~/$MY_WORKSPACE/src

cd ~/$MY_WORKSPACE
command catkin init

# set build profiles
catkin config --profile debug --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin profile set debug
catkin config --extend ~/mrs_workspace/devel

catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin profile set release
catkin config --extend ~/mrs_workspace/devel

catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color' -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
catkin profile set reldeb
catkin config --extend ~/mrs_workspace/devel

# clone templates repository
cd src

git clone --recursive git@mrs.felk.cvut.cz:uav/examples/example_packages

cd ~/$MY_WORKSPACE
command catkin build
