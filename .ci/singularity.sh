#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to the repository
THIS_PATH=`pwd`

echo $TOKEN >> /tmp/token

git clone https://github.com/ctu-mrs/mrs_singularity
cd $THIS_PATH/mrs_singularity/install
./install_singularity.sh
cd $THIS_PATH/mrs_singularity/recipes/04_with_linux_setup_uav_modules

echo ""
echo "Building Singularity image"

./build.sh

singularity remote login --tokenfile /tmp/token

singularity push -U 
