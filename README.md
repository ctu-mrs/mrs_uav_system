# Multi-robot Systems Group UAV system
![logos](.fig/logos.png)

![thumbnail](.fig/drone_collage.jpg)

The [Multi-robot Systems Group](http://mrs.felk.cvut.cz) is a robotics lab at the [Czech Technical University in Prague](https://www.cvut.cz/).
We specialize on multi-rotor helicopters, and for them specifically, we develop this control, estimation, and simulation system.
We think that real-world and replicable experiments should support excellent research and science in robotics.
Thus our platform is built to allow safe real-world experimental validation of approaches in planning, control, estimation, computer vision, tracking, and more.

## TL;DR what has changed from the old system

**Note:** The MRS UAV system v1.5 is still a Work-In-Progress and the documentation is undergoing maintanance.
You can find the changes and new instructions in here [WIP Google Document](https://docs.google.com/document/d/1NibHqNdyzzAYE7DNIMMq1HmzyFrBnISbzV17dP-waYw/edit?usp=sharing).
Any feedback is welcome (you can use the issues in this repo or comment on the Google Doc)!

## Installation

### Native installation

1. Install the Robot Operating System (Noetic):
```bash
curl https://ctu-mrs.github.io/ppa-unstable/add_ros_ppa.sh | bash
sudo apt install ros-noetic-desktop-full
```

2. Select which version of the MRS UAV System you want to install.

For **[stable](https://github.com/ctu-mrs/ppa-stable)** version, add the following PPA:
```bash
curl https://ctu-mrs.github.io/ppa-stable/add_ppa.sh | bash
```
For   **[unstable](https://github.com/ctu-mrs/ppa-unstable)** (nightly-build) of the system, add the following PPA:
```bash
curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash
```

Then, install the MRS UAV System:
```bash
sudo apt install ros-noetic-mrs-uav-system-full
```

3. Follow these instructions ([starting the simulation](https://ctu-mrs.github.io/docs/simulation/howto.html), **TODO update - see the [Google Doc](https://docs.google.com/document/d/1NibHqNdyzzAYE7DNIMMq1HmzyFrBnISbzV17dP-waYw/edit?usp=sharing) for now**) for starting the example simulation sessions.

4. Follow these instructions (**TOOD**) for creating your own catkin workspace and building your packages with the MRS UAV system.

### Singularity

Please, follow this link to learn how to run our system using Singularity.

* [MRS Singularity](https://github.com/ctu-mrs/mrs_singularity/tree/1.5)

## Build status

### x86-64/AMD64

|                         | [Stable](https://github.com/ctu-mrs/ppa-stable)                                                                                                                                                                | [Unstable](https://github.com/ctu-mrs/ppa-unstable)                                                                                                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MRS ROS Packages        | [![stable-mrs-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_mrs_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_mrs_amd64.yml)                      | [![unstable-mrs-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_mrs_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_mrs_amd64.yml)                      |
| Thirdparty ROS packages | [![stable-thirdparty-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_thirdparty_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_thirdparty_amd64.yml) | [![unstable-thirdparty-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_thirdparty_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_thirdparty_amd64.yml) |
| Non-ROS packages        | [![stable-nonbloom-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_nonbloom_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_nonbloom_amd64.yml)       | [![unstable-nonbloom-amd64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_nonbloom_amd64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_nonbloom_amd64.yml)       |

### AARCH64/ARM64

|                         | [Stable](https://github.com/ctu-mrs/ppa-stable)                                                                                                                                                                | [Unstable](https://github.com/ctu-mrs/ppa-unstable)                                                                                                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MRS ROS Packages        | [![stable-mrs-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_mrs_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_mrs_arm64.yml)                      | [![unstable-mrs-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_mrs_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_mrs_arm64.yml)                      |
| Thirdparty ROS packages | [![stable-thirdparty-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_thirdparty_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_thirdparty_arm64.yml) | [![unstable-thirdparty-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_thirdparty_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_thirdparty_arm64.yml) |
| Non-ROS packages        | [![stable-nonbloom-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_nonbloom_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/stable_nonbloom_arm64.yml)       | [![unstable-nonbloom-arm64](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_nonbloom_arm64.yml/badge.svg)](https://github.com/ctu-mrs/rosdistro/actions/workflows/unstable_nonbloom_arm64.yml)       |

## System components

| Main metapackages     | Contents                    | Repository                                                  | Package                                      |
|-----------------------|-----------------------------|-------------------------------------------------------------|----------------------------------------------|
| MRS UAV System - Full | Most of the bellow          | [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | `apt install ros-noetic-mrs-uav-system-full` |
| MRS UAV System        | Only UAV Core & UAV Modules | [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | `apt install ros-noetic-mrs-uav-system`      |

| Metapackages             | Repository                                                                          | Package                                               |
|--------------------------|-------------------------------------------------------------------------------------|-------------------------------------------------------|
| UAV Core                 | [mrs_uav_core](https://github.com/ctu-mrs/mrs_uav_core)                             | `apt install ros-noetic-mrs-uav-core`                 |
| UAV Modules              | [mrs_uav_modules](https://github.com/ctu-mrs/mrs_uav_modules)                       | `apt install ros-noetic-mrs-uav-modules`              |
| Octomap Mapping+Planning | [octomap_mapping_planning](https://github.com/ctu-mrs/mrs_octomap_mapping_planning) | `apt install ros-noetic-mrs-octomap-mapping-planning` |

| Simulators          | Repository                                                                            | Package                                              |
|---------------------|---------------------------------------------------------------------------------------|------------------------------------------------------|
| Gazebo Simulation   | [mrs_uav_gazebo_simulation](https://github.com/ctu-mrs/mrs_uav_gazebo_simulation)     | `apt install ros-noetic-mrs-uav-gazebo-simulation`   |
| MRS Simulation      | [mrs_multirotor_simulator](https://github.com/ctu-mrs/mrs_multirotor_simulator)       | `apt install ros-noetic-mrs-multirotor-simulator`    |
| Coppelia Simulation | [mrs_uav_coppelia_simulation](https://github.com/ctu-mrs/mrs_uav_coppelia_simulation) | `apt install ros-noetic-mrs-uav-coppelia-simulation` |

| Hardware API plugins | Repository                                                                | Package                                        |
|----------------------|---------------------------------------------------------------------------|------------------------------------------------|
| PX4 API              | [mrs_uav_px4_api](https://github.com/ctu-mrs/mrs_uav_px4_api)             | `apt install ros-noetic-mrs-uav-px4-api`       |
| DJI Tello API        | [mrs_uav_dji_tello_api](https://github.com/ctu-mrs/mrs_uav_dji_tello_api) | `apt install ros-noetic-mrs-uav-dji-tello-api` |

## Example packages

| Example           | Repository                                                                        |
|-------------------|-----------------------------------------------------------------------------------|
| Controller plugin | [example_controller_plugin](https://github.com/ctu-mrs/example_controller_plugin) |
| Tracker plugin    | [example_controller_plugin](https://github.com/ctu-mrs/example_tracker_plugin)    |

## System properties

The system is

* built on the [Robot Operating System](https://www.ros.org/) Noetic,
* meant to be executed entirely onboard on a companion computer,
* can control underactuated multirotor helicopters,
* contains control, state estimation, mapping and planning pipelines.

![](https://github.com/ctu-mrs/mrs_uav_system/raw/gifs/gazebo_circle.gif)

## [Documentation](https://ctu-mrs.github.io/)

The primary source of documentation is here: [https://ctu-mrs.github.io/](https://ctu-mrs.github.io/).
However, the website only scratches the surface of what it should contain (and we know it).
Our system is a research-oriented platform, and it evolves rapidly.
Most of our users are either researchers (who already know the platform) or freshmen students (who might not know ROS at all).
Maintaining up-to-date documentation for such an audience is hard work since we mostly spend our time developing the system while using it for our research.
So instead, we aim at educating our students to look around the packages (each contains its own README), explore the launch files, and be able to read the code, which we strive to keep readable.

[![](https://github.com/ctu-mrs/mrs_uav_system/raw/diagram/mrs_uav_system_diagram.jpg)](https://github.com/ctu-mrs/mrs_uav_system/raw/diagram/mrs_uav_system_diagram.pdf)

The control and estimation system are described in the article [doi.org/10.1007/s10846-021-01383-5](https://doi.org/10.1007/s10846-021-01383-5), [pdf](https://link.springer.com/content/pdf/10.1007/s10846-021-01383-5.pdf):
```
Baca, T., Petrlik, M., Vrba, M., Spurny, V., Penicka, R., Hert, D., and Saska, M.,
"The MRS UAV System: Pushing the Frontiers of Reproducible Research, Real-world Deployment, and
Education with Autonomous Unmanned Aerial Vehicles", J Intell Robot Syst 102, 26 (2021).
```

## Unmanned Aerial Vehicles

The MRS UAV system is currently pre-configured for the following UAV platforms, operated by the MRS.
The UAV platforms can be purchased from our partner company [Fly4Future](https://dronebuilder.fly4future.com/#/).

| Model        | Simulation                    | Real UAV                      |
|--------------|-------------------------------|-------------------------------|
| DJI f330     | ![](.fig/f330_simulation.jpg) | ![](.fig/f330_real.jpg)       |
| DJI f450     | ![](.fig/f450_simulation.jpg) | ![](.fig/f450_real.jpg)       |
| Holybro x500 | ![](.fig/x500_simulation.jpg) | ![](.fig/x500_real.jpg)       |
| DJI f550     | ![](.fig/f550_simulation.jpg) | ![](.fig/f550_real.jpg)       |
| Tarot t650   | ![](.fig/t650_simulation.jpg) | ![](.fig/t650_real.jpg)       |
| NAKI II      | ![](.fig/naki_simulation.jpg) | ![](.fig/naki_real.jpg)       |

## Backwards Compatibility and updates

We do not guarantee backward compatibility at any time.
The platform is evolving according to the needs of the MRS group.
Updates can be made that are not going to be compatible with users' local configs, simulation worlds, tmux sessions, etc.
However, when we change something that requires user action to maintain compatibility, we will create an issue in this repository labeled **users-read-me**.
Subscribe to this repository updates and issues by clicking the **Watch** button in the top-right corner of this page.
Recent changes requiring user action:

* August, 2023: **TODO** **Rehaul of the entire MRS UAV System**
* January 17, 2023: [Updates for px4 firmware v1.13.2](https://github.com/ctu-mrs/mrs_uav_system/issues/150)
* March 8, 2022: [mrs_lib::Transformer interface updated](https://github.com/ctu-mrs/mrs_uav_system/issues/136)
* December 09, 2021: [not building with --march=native anymore](https://github.com/ctu-mrs/mrs_uav_system/issues/126)
* December 25, 2020: [Updated controller interface, updated thrust curve parametrization](https://github.com/ctu-mrs/mrs_uav_system/issues/33)
* December 15, 2020: [Rework of simulation UAV spawning mechanism, Noetic update](https://github.com/ctu-mrs/mrs_uav_system/issues/32)
* November 12, 2020: [GPS coordinates within Gazebo world need changing](https://github.com/ctu-mrs/mrs_uav_system/issues/22)
* November 12, 2020: [Rangefinder fusion needs enabling in simulation sessions](https://github.com/ctu-mrs/mrs_uav_system/issues/21)
