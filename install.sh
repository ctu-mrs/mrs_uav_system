#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd $MY_PATH

while getopts "g:" options;
do
  case ${options} in
    g)
      GIT_PATH=$OPTARG
      shift
      ;;
  esac
done

n_cpu=`nproc --all`
RAM_size=`grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=2; {}/1024^2" | bc -l`
SWAP_size=`grep SwapTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=2; {}/1024^2" | bc -l`

total_available_memory=`echo $RAM_size + $SWAP_size | bc -l`
safe_rate_of_memory=`echo $n_cpu*2.5 | bc -l`

if (( $(echo "$safe_rate_of_memory > $total_available_memory" |bc -l) )); then
  recommended_swap_size=`echo $safe_rate_of_memory - $RAM_size | bc -l`
  rounded_recommended_swap_size=`echo "$recommended_swap_size"+1 | bc -l | awk '{print int($1)}'`
  echo ""
  echo "----------------------------------------------------------------------------------------------"
  echo "Installation can fail during compilation of the MRS system due to not sufficient RAM+SWAP memory"
  echo "              We recommend to have roughtly RAM+SWAP >= 2.5*number_of_cpu"
  echo "             -----------------------------------------------------------"
  echo "              Your number_of_cpu : $n_cpu" 
  echo "              Your RAM size      : $RAM_size GB" 
  echo "              Your SWAP size     : $SWAP_size GB" 
  echo "----------------------------------------------------------------------------------------------"
  echo "If so, please increase SWAP to recommended size, which is $recommended_swap_size GB".
  echo "To create $rounded_recommended_swap_size GB SWAP, follow these steps:"
  echo "-----------------------------------------------------------"
  echo "sudo swapoff -a"
  echo "sudo dd if=/dev/zero of=/swapfile bs=1GB count=$rounded_recommended_swap_size"
  echo "sudo chmod 600 /swapfile"
  echo "sudo mkswap /swapfile"
  echo "sudo swapon /swapfile"
  echo "grep SwapTotal /proc/meminfo"
  echo "-----------------------------------------------------------"
  echo ""
  echo "Press Enter to continue..."
  echo ""
  read
fi

[ -z "$GIT_PATH" ] && GIT_PATH=~/git

## | ----------------------- install ROS ---------------------- |

bash $MY_PATH/dependencies/ros.sh

## | --------------------- install gitman --------------------- |

bash $MY_PATH/dependencies/gitman.sh

## | ------------------ crate the git folder ------------------ |

[ ! -e "$GIT_PATH" ] && echo "$0: creating $GIT_PATH" && mkdir -p $GIT_PATH

## | -------------------- cloning packages -------------------- |

cd "$GIT_PATH"

[ ! -e "$GIT_PATH/uav_core" ] && git clone https://github.com/ctu-mrs/uav_core
[ ! -e "$GIT_PATH/simulation" ] && git clone https://github.com/ctu-mrs/simulation
[ ! -e "$GIT_PATH/example_ros_packages" ] && git clone https://github.com/ctu-mrs/example_ros_packages

## | ------------------- installing uav_core ------------------ |

echo "$0: installing uav_core"
$GIT_PATH/uav_core/installation/install.sh

## | ------------------ installing simulation ----------------- |

echo "$0: installing simulation"
$GIT_PATH/simulation/installation/install.sh

## | ------------------- setup mrs_workspace ------------------ |

$MY_PATH/scripts/set_mrs_workspace.sh

## | --------------------- setup workspace -------------------- |

$MY_PATH/scripts/set_my_workspace.sh

## | ------- add workspaces to ROS_WORKSPACES in .bashrc ------ |

num=`cat ~/.bashrc | grep "ROS_WORKSPACES" | wc -l`
if [ "$num" -lt "1" ]; then

  # set bashrc
  echo "
export ROS_WORKSPACES=\"~/mrs_workspace ~/workspace\"" >> ~/.bashrc

fi
