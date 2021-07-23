#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "$0: installing Gitman"

distro=`lsb_release -r | awk '{ print $2 }'`

if [ "$distro" = "18.04" ]; then

  sudo apt-get -y install python-pip python3-pip python-setuptools python3-setuptools

  sudo pip3 install gitman
  sudo -H pip3 install gitman

elif [ "$distro" = "20.04" ]; then

  sudo apt-get -y install python3-pip python3-setuptools

  sudo pip3 install gitman==2.3.0
  sudo -H pip3 install gitman==2.3.0

fi
