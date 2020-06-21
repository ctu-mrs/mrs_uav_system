#!/bin/bash
# author: Robert Penicka
set -e

echo "Starting install preparation" 
openssl aes-256-cbc -K $encrypted_f0fd3ee254e8_key -iv $encrypted_f0fd3ee254e8_iv -in ./.ci/deploy_key_github.enc -out ./.ci/deploy_key_github -d
eval "$(ssh-agent -s)"
chmod 600 ./.ci/deploy_key_github
ssh-add ./.ci/deploy_key_github

sudo apt-get update -qq
sudo apt-mark hold openssh-server
sudo apt -y upgrade --fix-missing

sudo apt-get install git # dpkg python-setuptools python3-setuptools python3-pip

echo "running the main install.sh"
./install.sh

echo "install part ended"
