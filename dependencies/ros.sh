#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

debian=`uname -a | grep -i debian | wc -l`
[[ "$debian" -eq "1" ]] && ROS_DISTRO="noetic"

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

distro=`lsb_release -r | awk '{ print $2 }'`

echo "$0: Installing ROS"

# add repository for ignition library
sudo apt-get -y install wget lsb-release gnupg
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $ROS_DISTRO main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get -y update

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $ROS_DISTRO main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-get -y install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt-get -y update

[ "$distro" = "18.04" ] && sudo apt-get -y install ros-melodic-desktop-full
[ "$distro" = "20.04" ] && sudo apt-get -y install ros-noetic-desktop-full

num=`cat ~/.bashrc | grep "/opt/ros/$ROS_DISTRO/setup.bash" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

fi
