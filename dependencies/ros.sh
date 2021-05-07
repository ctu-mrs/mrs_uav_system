#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

distro=`lsb_release -r | awk '{ print $2 }'`

echo "$0: Installing ROS"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    sudo apt-key adv --keyserver "$server" --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && break || echo "Trying new server..."
done

sudo apt-get -y update

[ "$distro" = "18.04" ] && sudo apt-get -y install ros-melodic-desktop-full
[ "$distro" = "20.04" ] && sudo apt-get -y install ros-noetic-desktop-full

# add repository for ignition library
sudo apt-get -y install wget lsb-release gnupg
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get -y update

num=`cat ~/.bashrc | grep "/opt/ros/$ROS_DISTRO/setup.bash" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

fi
