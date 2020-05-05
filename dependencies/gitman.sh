#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "$0: installing Gitman"

sudo apt -y install python-pip python3-pip

sudo pip3 install gitman
sudo -H pip3 install gitman
