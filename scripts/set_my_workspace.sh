#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

WORKSPACE_NAME=workspace
WORKSPACE_PATH=~/$WORKSPACE_NAME
MRS_WORKSPACE=~/mrs_workspace

# create the folder structure
mkdir -p $WORKSPACE_PATH

cd $WORKSPACE_PATH
command catkin init

echo "$0: setting up build profiles"
command catkin config --profile debug --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
command catkin profile set debug
command catkin config --extend $MRS_WORKSPACE/devel

command catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color'  -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
command catkin profile set release
command catkin config --extend $MRS_WORKSPACE/devel

command catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -march=native -fno-diagnostics-color' -DCMAKE_C_FLAGS='-march=native -fno-diagnostics-color'
command catkin profile set reldeb
command catkin config --extend $MRS_WORKSPACE/devel

echo "$0: cloning example packages"
cd ~/git
[ ! -e example_ros_packages ] && git clone git@github.com:ctu-mrs/example_ros_packages
cd example_ros_packages
gitman install

echo "$0: linking example packages to ~/workspace"
cd $WORKSPACE_PATH/src
ln -sf ~/git/example_ros_packages

echo "$0: building $WORKSPACE_PATH"
cd $WORKSPACE_PATH
command catkin build

num=`cat ~/.bashrc | grep "$WORKSPACE_PATH" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
  
fi

exit 0
