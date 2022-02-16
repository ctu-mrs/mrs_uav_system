#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

docker login --username klaxalk --password $TOKEN

docker build . --file docker/without_linux_setup_modules --tag ctumrs/mrs_uav_system_modules:latest

docker push ctumrs/mrs_uav_system_modules:latest

WEEK_TAG="`date +%Y`_w`date +%V`"
docker tag ctumrs/mrs_uav_system_modules:latest ctumrs/mrs_uav_system_modules:$WEEK_TAG

docker push ctumrs/mrs_uav_system_modules:$WEEK_TAG
