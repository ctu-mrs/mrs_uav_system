#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "$0: installing ROS"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    sudo apt-key adv --keyserver "$server" --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && break || echo "Trying new server..."
done

sudo apt -y update
sudo apt -y install ros-melodic-desktop-full

num=`cat ~/.bashrc | grep "/opt/ros/melodic/setup.bash" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
source /opt/ros/melodic/setup.bash" >> ~/.bashrc
  
fi
