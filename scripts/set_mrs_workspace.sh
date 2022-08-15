#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

debian=`lsb_release -d | grep -i debian | wc -l`
[[ "$debian" -ge "1" ]] && ROS_DISTRO="noetic" && echo we are on DEBIAN

# shift
OPTIND=1
NO_BUILD=false
while getopts "g:l:n" options; do
  case ${options} in
    g)
      GIT_PATH=${OPTARG}
      echo "Parsed GIT_PATH=$GIT_PATH"
      ;;
    l)
      WORKSPACE_LOCATION=${OPTARG}
      echo "Parsed WORKSPACE_LOCATION=$WORKSPACE_LOCATION"
      ;;
    n)
      NO_BUILD=true
      echo "NO_BUILD=true"
      ;;
  esac
done

[ -z "$WORKSPACE_LOCATION" ] && WORKSPACE_LOCATION="$HOME"
[ -z "$GIT_PATH" ] && GIT_PATH="$HOME/git"

echo "Setting up workspace: WORKSPACE_LOCATION=$WORKSPACE_LOCATION, GIT_PATH=$GIT_PATH"

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

WORKSPACE_NAME=mrs_workspace
WORKSPACE_PATH=$WORKSPACE_LOCATION/$WORKSPACE_NAME

echo "$0: creating $WORKSPACE_PATH/src"
mkdir -p $WORKSPACE_PATH/src

cd $WORKSPACE_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
command catkin init

echo "$0: setting up build profiles"
command catkin config --profile debug --cmake-args -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17 -Og' -DCMAKE_C_FLAGS='-Og'
command catkin config --profile release --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'
command catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS='-std=c++17'

# build profile for normal installation
[ -z "$GITHUB_CI" ] && command catkin profile set reldeb

# build profile for github actions
[ ! -z "$GITHUB_CI" ] && command catkin profile set debug

command catkin config --extend /opt/ros/$ROS_DISTRO

# link mrs repositories to the workspace
cd src
ln -sf $GIT_PATH/uav_core
ln -sf $GIT_PATH/simulation

cd $WORKSPACE_PATH

if ! $NO_BUILD; then
  [ -z "$GITHUB_CI" ] && command catkin build mavros -c --mem-limit 75%
  [ ! -z "$GITHUB_CI" ] && command catkin build mavros --limit-status-rate 0.2 --summarize
  [ -z "$GITHUB_CI" ] && command catkin build mavlink_sitl_gazebo -c --mem-limit 75%
  [ ! -z "$GITHUB_CI" ] && command catkin build mavlink_sitl_gazebo --limit-status-rate 0.2 --summarize
  [ -z "$GITHUB_CI" ] && command catkin build mrs_gazebo_common_resources -c --mem-limit 75%
  [ ! -z "$GITHUB_CI" ] && command catkin build mrs_gazebo_common_resources --limit-status-rate 0.2 --summarize
  [ -z "$GITHUB_CI" ] && command catkin build -c --mem-limit 75%
  [ ! -z "$GITHUB_CI" ] && command catkin build --limit-status-rate 0.2 --summarize
fi

# blackilst our tf2 fork on melodic
if [[ "$ROS_DISTRO" == "melodic" ]]; then

  echo "Blacklisting custom tf2 due to being on melodic"

  cd $WORKSPACE_PATH
  catkin config --blacklist "geometry2 test_tf2 tf2 tf2_bullet tf2_eigen tf2_geometry_msgs tf2_kdl tf2_msgs tf2_py tf2_ros tf2_sensor_msgs tf2_tools"

fi

num=`cat ~/.bashrc | grep "$WORKSPACE_PATH" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc

fi
