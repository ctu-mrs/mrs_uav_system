#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command failed with exit code $?"' ERR

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

[ -z "$GIT_PATH" ] && GIT_PATH=~/git

## | ----------------------- install ROS ---------------------- |

bash $MY_PATH/dependencies/ros.sh

## | --------------------- install gitman --------------------- |

bash $MY_PATH/dependencies/gitman.sh

## | ------------------ crate the git folder ------------------ |

[ ! -e "$GIT_PATH" ] && echo "$0: creating $GIT_PATH" && mkdir -p $GIT_PATH

## | --------------------- claning packags -------------------- |

[ ! -e "$GIT_PATH/uav_core" ] && git clone git@github.com:ctu-mrs/uav_core
[ ! -e "$GIT_PATH/simulation" ] && git clone git@github.com:ctu-mrs/simulation
[ ! -e "$GIT_PATH/example_ros_packages" ] && git clone git@github.com:ctu-mrs/example_ros_packages

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

exit 0
