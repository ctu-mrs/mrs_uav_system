#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

WORKSPACE_NAME=mrs_workspace
WORKSPACE_PATH=~/$WORKSPACE_NAME

echo "$0: creating $WORKSPACE_PATH/src"
mkdir -p $WORKSPACE_PATH/src

cd $WORKSPACE_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
command catkin init

echo "$0: setting up build profiles"
command catkin config --profile debug --cmake-args -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'
command catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'
command catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'

# build profile for normal installation
[ -z "$GITHUB_CI" ] && command catkin profile set reldeb

# build profile for github actions
[ ! -z "$GITHUB_CI" ] && command catkin profile set debug

# link mrs repositories to the workspace
cd src
ln -sf ~/git/uav_core
ln -sf ~/git/simulation

cd $WORKSPACE_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
[ -z "$GITHUB_CI" ] && command catkin build mavros -c --mem-limit 75%
[ ! -z "$GITHUB_CI" ] && command catkin build mavros --limit-status-rate 0.2 --summarize
[ -z "$GITHUB_CI" ] && command catkin build mavlink_sitl_gazebo -c --mem-limit 75%
[ ! -z "$GITHUB_CI" ] && command catkin build mavlink_sitl_gazebo --limit-status-rate 0.2 --summarize
[ -z "$GITHUB_CI" ] && command catkin build mrs_gazebo_common_resources -c --mem-limit 75%
[ ! -z "$GITHUB_CI" ] && command catkin build mrs_gazebo_common_resources --limit-status-rate 0.2 --summarize
[ -z "$GITHUB_CI" ] && command catkin build -c --mem-limit 75%
[ ! -z "$GITHUB_CI" ] && command catkin build --limit-status-rate 0.2 --summarize

num=`cat ~/.bashrc | grep "$WORKSPACE_PATH" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc

fi
