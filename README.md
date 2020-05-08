# Multi-robot Systems Group UAV system

![UAV collage](.fig/drone_collage.jpg)

### Build Status

| Component                                                   | Ubuntu | Status                                                                                                                          | Description                                                                                                                                                    |
|-------------------------------------------------------------|--------|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/mrs_uav_system.svg?branch=master)](https://travis-ci.com/ctu-mrs/mrs_uav_system) | the whole system, integrates [uav_core](https://github.com/ctu-mrs/uav_core) and [simulation](https://github.com/ctu-mrs/simulation), prepares the build space |
| [uav_core](https://github.com/ctu-mrs/uav_core)             | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/uav_core.svg?branch=master)](https://travis-ci.com/ctu-mrs/uav_core)             | UAV control and estimation pipeline                                                                                                                            |
| [simulation](https://github.com/ctu-mrs/simulation)         | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/simulation.svg?branch=master)](https://travis-ci.com/ctu-mrs/simulation)         | Gazebo/ROS UAV simulation tools                                                                                                                                |
| [linux-setup](https://github.com/klaxalk/linux-setup)       | Bionic | [![Build Status](https://travis-ci.com/klaxalk/linux-setup.svg?branch=master)](https://travis-ci.com/klaxalk/linux-setup)       | Linux configuration focused on development in terminal                                                                                                         |

# Installation

Following options are provided, depending on who you are and what you want to do with the platform

## "I have a fresh Ubuntu 18.04 and want it quick and easy"

In this case we provide installation scripts that set everything up for you.
Our automated installation will:
* install Robot Operating System (ROS),
* install other dependencies such *git*, *gitman*,
* clone [uav_core](https://github.com/ctu-mrs/uav_core), [simulation](https://github.com/ctu-mrs/simulation), [example_ros_packages](https://github.com/ctu-mrs/example_ros_packages) into *~/git*,
* install more dependencies such as *tmux* and *tmuxinator*
* create our ros workspace in ```~/mrs_workspace``` for the *uav_core* and *simulation*,
* create a ros workspace in ```~/workspace``` for *examples*,
* link our packages to the workspaces,
* compile the workspaces,
* added configuration lines into your *~/.bashrc*.

To start the automatic installation, please paste the following code into your terminal and press **enter**.
You might be prompted a few times to confirm something by pressing enter, but most of the choice have an automatic default answer.
```bash
cd /tmp
echo '
GIT_PATH=~/git
mkdir -p $GIT_PATH
cd $GIT_PATH
sudo apt -y install git
git clone https://github.com/ctu-mrs/mrs_uav_system
cd mrs_uav_system
git checkout master
git pull
./install.sh -g $GIT_PATH' > clone.sh && source clone.sh
```

## "I already have ROS and just want to peek in"

If you already have ROS installed and if you are fluent with *workspaces*, *.bashrc*, *catkin tools*, etc., you can clone our repositories individually manually.
The [uav_core](https://github.com/ctu-mrs/uav_core) repository integrates our UAV control system.
Please follow its README for further instructions on how to install its particular dependencies.

The [simulation](https://github.com/ctu-mrs/simulation) repository provides resources for *Gazebo/ROS* simulation, including px4 Simulation-in-the-Loop (SITL), UAV models and useful sensor plugins.
Please follow its README for further instructions on how to install prerequisities.

## "I want the nice Linux environment that everybody from MRS works with"

Great! In that case you want to install Tomas's Linux-setup.
**Beware!** This might alter you existing configuration of some Linux tools (Vim, Tmux, i3wm, ranger, ...).
Refer to its [README](https://github.com/klaxalk/linux-setup), for more information.
Installation is *not* obligatory and the MRS UAV system will work without it.

Paste following code into your terminal and press **enter**
```bash
cd /tmp
echo "mkdir -p ~/git
cd ~/git
sudo apt -y install git
git clone https://github.com/klaxalk/linux-setup
cd linux-setup
./install.sh" > run.sh && source run.sh
```
