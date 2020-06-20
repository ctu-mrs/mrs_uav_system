# Multi-robot Systems Group UAV system
![thumbnail](.fig/drone_collage.jpg)

The [Multi-robot Systems Group](http://mrs.felk.cvut.cz) is a robotics lab at the [Czech Technical University in Prague](https://www.cvut.cz/).
We mostly work with multi-rotor helicopters, and for them specifically, we develop this control, estimation, and simulation platform.
We think that real-world and replicable experiments should support excellent research and science in robotics.
Thus our platform is built to allow safe verification of approaches in planning, control, estimation, computer vision, tracking, and more.

### Build Status

| Component                                                   | Ubuntu | Status                                                                                                                          | Description                                                                                                                                  |
|-------------------------------------------------------------|--------|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/mrs_uav_system.svg?branch=master)](https://travis-ci.com/ctu-mrs/mrs_uav_system) | integrates [uav_core](https://github.com/ctu-mrs/uav_core) and [simulation](https://github.com/ctu-mrs/simulation), prepares the build space |
| [uav_core](https://github.com/ctu-mrs/uav_core)             | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/uav_core.svg?branch=master)](https://travis-ci.com/ctu-mrs/uav_core)             | UAV control and estimation pipeline                                                                                                          |
| [simulation](https://github.com/ctu-mrs/simulation)         | Bionic | [![Build Status](https://travis-ci.com/ctu-mrs/simulation.svg?branch=master)](https://travis-ci.com/ctu-mrs/simulation)         | Gazebo/ROS UAV simulation tools                                                                                                              |
| [linux-setup](https://github.com/klaxalk/linux-setup)       | Bionic | [![Build Status](https://travis-ci.com/klaxalk/linux-setup.svg?branch=master)](https://travis-ci.com/klaxalk/linux-setup)       | Linux configuration focused on development in terminal                                                                                       |

## System properties

The platform is

* built using [Robot Operating System](https://www.ros.org/) (Melodic),
* meant to be executed entirely onboard,
* can be deployed on any multi-rotor vehicle, given it is equipped with a [PX4](https://github.com/ctu-mrs/px4_firmware)-compatible [flight controller](https://pixhawk.org/),
* for both indoor and outdoor,
* supports multi-robot experiments using [Nimbro network](https://github.com/ctu-mrs/nimbro_network) communication.
* provides both: agile flying and robust control.

![](https://github.com/ctu-mrs/mrs_uav_system/raw/gifs/gazebo_circle.gif)

### Documentation

The primary source of documentation is here: [https://ctu-mrs.github.io/](https://ctu-mrs.github.io/).
However, it barely scratches a surface of what it should contain (and we know it).
Our system is a research-oriented platform, and it evolves rapidly.
Most of our users are either researchers (who already know the platform) or freshmen students (who might not know ROS at all).
Maintaining up-to-date documentation for such an audience is hard work, since we mostly spend our time developing the system while using it for our research.
So instead, we aim at educating our students to look around the packages (each contains its own README), explore the launch files and be able to read the code, which we strive to keep readable.

Basics of the control and estimation pipeline are described in the [preprint](http://mrs.felk.cvut.cz/data/papers/mrs-platform.pdf).

### Unmanned Aerial Vehicles

The MRS UAV system is currently pre-configured for the following UAV platforms, operated by the MRS:

| Model      | Simulation                    | Real UAV                |
|------------|-------------------------------|-------------------------|
| DJI f450   | ![](.fig/f450_simulation.jpg) | ![](.fig/f450_real.jpg) |
| DJI f550   | ![](.fig/f550_simulation.jpg) | ![](.fig/f550_real.jpg) |
| Tarot t650 | ![](.fig/t650_simulation.jpg) | ![](.fig/t650_real.jpg) |

## Related packages - not being part of the installation

| Package                                                                              | Description                                                                                   |
|--------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [MRS Gazebo Extra Resources](https://github.com/ctu-mrs/mrs_gazebo_extras_resources) | *MRS System*-depended optional plugins and resources                                          |
| [Nimbro network](https://github.com/ctu-mrs/nimbro_network)                          | ROS communication layer for multiple independent machines                                     |
| [Hector SLAM](https://github.com/tu-darmstadt-ros-pkg/hector_slam)                   | 2D Laser-based LIDAR SLAM, [how to](https://ctu-mrs.github.io/docs/software/hector_slam.html) |
| [MRS Serial](https://github.com/ctu-mrs/mrs_serial)                                  | serial line interface to ROS, communicates using the BACA protocol                            |

## Installation

Following options are provided, depending on who you are and what you want to do with the platform

### "I have a fresh Ubuntu 18.04 and want it quick and easy"

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
You might be prompted a few times to confirm something by pressing enter:
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
./install.sh -g $GIT_PATH
source ~/.bashrc' > clone.sh && source clone.sh
```

### "I already have ROS and just want to peek in"

If you already have ROS installed and if you are fluent with *workspaces*, *.bashrc*, *catkin tools*, etc., feel free to clone our repositories individually.
The [uav_core](https://github.com/ctu-mrs/uav_core) repository integrates our UAV control system.
Please follow its README for further instructions on how to install its particular dependencies.

The [simulation](https://github.com/ctu-mrs/simulation) repository provides resources for *Gazebo/ROS* simulation, including px4 Simulation-in-the-Loop (SITL), UAV models and useful sensor plugins.
Please follow its README for further instructions on how to install prerequisities.

### "I want the Linux environment people from MRS works with"

Great! In that case you want to install Tomas's Linux-setup.
**Beware!** This might alter your existing configuration of some Linux tools (Vim, Tmux, i3wm, ranger, ...).
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
