#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

docker build . --file docker/without_linux_setup --tag ctumrs/mrs_uav_system:latest

docker login --username klaxalk --password $TOKEN

docker push ctumrs/mrs_uav_system:latest

WEEK_TAG="`date +%Y`_w`date +%V`"
docker push ctumrs/mrs_uav_system:$WEEK_TAG
