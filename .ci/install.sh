#!/bin/bash
# author: Robert Penicka
set -e

sudo apt-get -y update -qq
sudo apt-mark hold openssh-server # the installation might get stuck while upgrading this
sudo apt-mark hold msodbcsql17 mssql-tools # microsoft wants to manually accept EULA while upgrading this

# 20.04 problem fix
sudo apt-get -y install grub-efi
sudo update-grub

# the "gce-compute-image-packages" package often freezes the installation at some point
# the installation freezes when it tries to manage some systemd services
# this attempts to install the package and stop the problematic service during the process
((sleep 90 && (sudo systemctl stop google-instance-setup.service && echo "gce service stoped" || echo "gce service not stoped")) & (sudo timeout 120s apt-get -y install gce-compute-image-packages)) || echo "\e[1;31mInstallation of gce-compute-image-packages failed\e[0m"

sudo apt-get -y upgrade --fix-missing

sudo apt-get -y install git # dpkg python-setuptools python3-setuptools python3-pip

echo "running the main install.sh"
./install.sh

echo "install part ended"
