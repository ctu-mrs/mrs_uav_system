#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

## | ---------------- download dockers gpg key ---------------- |

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## | ----------------- setup stable repository ---------------- |

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## | ------------------ install docker engine ----------------- |

sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

docker login --username klaxalk --password $TOKEN

docker build . --file docker/without_linux_setup --tag ctumrs/mrs_uav_system_arm:latest

docker push ctumrs/mrs_uav_system_arm:latest

WEEK_TAG="`date +%Y`_w`date +%V`"
docker tag ctumrs/mrs_uav_system_arm:latest ctumrs/mrs_uav_system_arm:$WEEK_TAG

docker push ctumrs/mrs_uav_system_arm:$WEEK_TAG
