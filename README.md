# Multi-robot Systems Group UAV system
![logos](.fig/logos.png)

![thumbnail](.fig/drone_collage.jpg)

The [Multi-robot Systems Group](http://mrs.felk.cvut.cz) is a robotics lab at the [Czech Technical University in Prague](https://www.cvut.cz/).
We specialize in multi-rotor helicopters, and for them specifically, we develop this control, estimation, and simulation system.
We think real-world and replicable experiments should support excellent research and science in robotics.
Thus, our platform is built to allow safe real-world experimental validation of approaches in planning, control, estimation, computer vision, tracking, and more.

> :warning: **Attention please: This README needs work.**
>
> The MRS UAV System 1.5 is being released, and this page needs updating. Please remember that the information on this page might not be valid.
> Check this [WIP Google Document](https://docs.google.com/document/d/1NibHqNdyzzAYE7DNIMMq1HmzyFrBnISbzV17dP-waYw/edit?usp=sharing) for the latest news and changes.

## TL;DR What has changed from the old system

**Note:** The MRS UAV system v1.5 is still a Work-In-Progress and the documentation is undergoing maintanance ([Issue#169](https://github.com/ctu-mrs/mrs_uav_system/issues/169)).
You can find the changes and new instructions in here [WIP Google Document](https://docs.google.com/document/d/1NibHqNdyzzAYE7DNIMMq1HmzyFrBnISbzV17dP-waYw/edit?usp=sharing).
Any feedback is welcome (you can use the issues in this repo or comment on the Google Doc)!

## System properties

The system is

* built on the [Robot Operating System](https://www.ros.org/) Noetic,
* meant to be executed entirely onboard on a companion computer,
* can control underactuated multirotor helicopters,
* contains control, state estimation, mapping, and planning pipelines.

![](https://github.com/ctu-mrs/mrs_uav_system/raw/gifs/gazebo_circle.gif)

## [Documentation](https://ctu-mrs.github.io/)

The primary documentation source is here: [https://ctu-mrs.github.io/](https://ctu-mrs.github.io/).
However, the website only scratches the surface of what it should contain (and we know it).
Our system is a research-oriented platform, and it evolves rapidly.
Most of our users are either researchers (who already know the platform) or freshmen students (who might not know ROS).
Maintaining up-to-date documentation for such an audience is hard work since we mostly develop the system while using it for our research.
So, instead, we aim at educating our students to look around the packages (each contains its own README), explore the launch files, and be able to read the code, which we strive to keep readable.

[![](https://github.com/ctu-mrs/mrs_uav_system/raw/diagram/mrs_uav_system_diagram.jpg)](https://github.com/ctu-mrs/mrs_uav_system/raw/diagram/mrs_uav_system_diagram.pdf)

The control and estimation system are described in the article [doi.org/10.1007/s10846-021-01383-5](https://doi.org/10.1007/s10846-021-01383-5), [pdf](https://link.springer.com/content/pdf/10.1007/s10846-021-01383-5.pdf):
```
Baca, T., Petrlik, M., Vrba, M., Spurny, V., Penicka, R., Hert, D., and Saska, M.,
"The MRS UAV System: Pushing the Frontiers of Reproducible Research, Real-world Deployment, and
Education with Autonomous Unmanned Aerial Vehicles", J Intell Robot Syst 102, 26 (2021).
```

## Installation

### Native installation

1. Install the Robot Operating System (Noetic):
```bash
curl https://ctu-mrs.github.io/ppa-unstable/add_ros_ppa.sh | bash
sudo apt install ros-noetic-desktop-full
```

2. Configure your ROS environment according to [http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment](http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment)

3. Select which version of the MRS UAV System you want to install.

For **[stable](https://github.com/ctu-mrs/ppa-stable)** version, add the stable PPA:
```bash
curl https://ctu-mrs.github.io/ppa-stable/add_ppa.sh | bash
```
For **[unstable](https://github.com/ctu-mrs/ppa-unstable)** (nightly-build) of the system, add the unstable PPA:
```bash
curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash
```

4. Install the MRS UAV System:
```bash
sudo apt install ros-noetic-mrs-uav-system-full
```

5. Start the example Gazebo simulation session:
```bash
roscd mrs_uav_gazebo_simulation/tmux/one_drone
./start.sh
```

### Singularity Containers

Please follow this link to learn how to run our system using Singularity.

* [MRS Singularity](https://github.com/ctu-mrs/mrs_singularity)

## System components

| Main metapackages     | Contents               | Repository                                                  | Package                          |
|-----------------------|------------------------|-------------------------------------------------------------|----------------------------------|
| MRS UAV System        | UAV Core & UAV Modules | [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | `ros-noetic-mrs-uav-system`      |
| MRS UAV System - Full | All of the bellow      | [mrs_uav_system](https://github.com/ctu-mrs/mrs_uav_system) | `ros-noetic-mrs-uav-system-full` |

| Metapackages             | Repository                                                                              | Package                                   |
|--------------------------|-----------------------------------------------------------------------------------------|-------------------------------------------|
| UAV Core                 | [mrs_uav_core](https://github.com/ctu-mrs/mrs_uav_core)                                 | `ros-noetic-mrs-uav-core`                 |
| UAV Modules              | [mrs_uav_modules](https://github.com/ctu-mrs/mrs_uav_modules)                           | `ros-noetic-mrs-uav-modules`              |
| Octomap Mapping+Planning | [mrs_octomap_mapping_planning](https://github.com/ctu-mrs/mrs_octomap_mapping_planning) | `ros-noetic-mrs-octomap-mapping-planning` |
| ALOAM Core               | [mrs_aloam_core](https://github.com/ctu-mrs/mrs_aloam_core)                             | `ros-noetic-mrs-aloam-core`               |
| Hector Core              | [mrs_hector_core](https://github.com/ctu-mrs/mrs_hector_core)                           | `ros-noetic-mrs-hector-core`              |
| OpenVINS Core            | [mrs_open_vins_core](https://github.com/ctu-mrs/mrs_open_vins_core)                     | `ros-noetic-mrs-open-vins-core`           |

| Simulators          | Repository                                                                            | Package                                  |
|---------------------|---------------------------------------------------------------------------------------|------------------------------------------|
| Gazebo Simulation   | [mrs_uav_gazebo_simulation](https://github.com/ctu-mrs/mrs_uav_gazebo_simulation)     | `ros-noetic-mrs-uav-gazebo-simulation`   |
| MRS Simulation      | [mrs_multirotor_simulator](https://github.com/ctu-mrs/mrs_multirotor_simulator)       | `ros-noetic-mrs-multirotor-simulator`    |
| Coppelia Simulation | [mrs_uav_coppelia_simulation](https://github.com/ctu-mrs/mrs_uav_coppelia_simulation) | `ros-noetic-mrs-uav-coppelia-simulation` |

| Hardware API plugins | Repository                                                                | Package                            |
|----------------------|---------------------------------------------------------------------------|------------------------------------|
| PX4 API              | [mrs_uav_px4_api](https://github.com/ctu-mrs/mrs_uav_px4_api)             | `ros-noetic-mrs-uav-px4-api`       |
| DJI Tello API        | [mrs_uav_dji_tello_api](https://github.com/ctu-mrs/mrs_uav_dji_tello_api) | `ros-noetic-mrs-uav-dji-tello-api` |

## Example packages

| Examples          | Repository                                                          | Build status                                                                                                                                                                                          |
|-------------------|---------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MRS Core examples | [mrs_core_examples](https://github.com/ctu-mrs/mrs_core_examples)   | [![ros_build_test](https://github.com/ctu-mrs/mrs_core_examples/actions/workflows/ros_build_test.yml/badge.svg)](https://github.com/ctu-mrs/mrs_core_examples/actions/workflows/ros_build_test.yml)   |
| Vision example    | [example_ros_vision](https://github.com/ctu-mrs/example_ros_vision) | [![ros_build_test](https://github.com/ctu-mrs/example_ros_vision/actions/workflows/ros_build_test.yml/badge.svg)](https://github.com/ctu-mrs/example_ros_vision/actions/workflows/ros_build_test.yml) |

## Build status ([Buildfarm](https://github.com/ctu-mrs/buildfarm))

### PPAs

| [Stable](https://github.com/ctu-mrs/ppa-stable)                                                                                                                         | [Unstable](https://github.com/ctu-mrs/ppa-unstable)                                                                                                                           |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![stable-ppa-build](https://github.com/ctu-mrs/ppa-stable/actions/workflows/deploy.yml/badge.svg)](https://github.com/ctu-mrs/ppa-stable/actions/workflows/deploy.yml) | [![unstable-ppa-build](https://github.com/ctu-mrs/ppa-unstable/actions/workflows/deploy.yml/badge.svg)](https://github.com/ctu-mrs/ppa-unstable/actions/workflows/deploy.yml) |

### x86-64/AMD64

|                         | [Stable](https://github.com/ctu-mrs/ppa-stable)                                                                                                                                                                | [Unstable](https://github.com/ctu-mrs/ppa-unstable)                                                                                                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MRS ROS Packages        | [![stable-mrs-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_mrs_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_mrs_amd64.yml)                      | [![unstable-mrs-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_mrs_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_mrs_amd64.yml)                      |
| Thirdparty ROS packages | [![stable-thirdparty-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_thirdparty_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_thirdparty_amd64.yml) | [![unstable-thirdparty-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_thirdparty_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_thirdparty_amd64.yml) |
| Non-ROS packages        | [![stable-nonbloom-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_nonbloom_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_nonbloom_amd64.yml)       | [![unstable-nonbloom-amd64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_nonbloom_amd64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_nonbloom_amd64.yml)       |

### AARCH64/ARM64

|                         | [Stable](https://github.com/ctu-mrs/ppa-stable)                                                                                                                                                                | [Unstable](https://github.com/ctu-mrs/ppa-unstable)                                                                                                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MRS ROS Packages        | [![stable-mrs-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_mrs_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_mrs_arm64.yml)                      | [![unstable-mrs-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_mrs_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_mrs_arm64.yml)                      |
| Thirdparty ROS packages | [![stable-thirdparty-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_thirdparty_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_thirdparty_arm64.yml) | [![unstable-thirdparty-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_thirdparty_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_thirdparty_arm64.yml) |
| Non-ROS packages        | [![stable-nonbloom-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_nonbloom_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/stable_nonbloom_arm64.yml)       | [![unstable-nonbloom-arm64](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_nonbloom_arm64.yml/badge.svg)](https://github.com/ctu-mrs/buildfarm/actions/workflows/unstable_nonbloom_arm64.yml)       |

## Unmanned Aerial Vehicles

The MRS UAV system is pre-configured for the following UAV platforms operated by the MRS.
The UAV platforms can be purchased from our partner company [Fly4Future](https://dronebuilder.fly4future.com/#/).

| Model        | Simulation                    | Real UAV                |
|--------------|-------------------------------|-------------------------|
| DJI f330     | ![](.fig/f330_simulation.jpg) | ![](.fig/f330_real.jpg) |
| DJI f450     | ![](.fig/f450_simulation.jpg) | ![](.fig/f450_real.jpg) |
| Holybro x500 | ![](.fig/x500_simulation.jpg) | ![](.fig/x500_real.jpg) |
| DJI f550     | ![](.fig/f550_simulation.jpg) | ![](.fig/f550_real.jpg) |
| Tarot t650   | ![](.fig/t650_simulation.jpg) | ![](.fig/t650_real.jpg) |
| NAKI II      | ![](.fig/naki_simulation.jpg) | ![](.fig/naki_real.jpg) |

## Backwards Compatibility and updates

We do not guarantee backward compatibility at any time.
The platform is evolving according to the needs of the MRS group.
Updates can be made that will not be compatible with users' local configs, simulation worlds, tmux sessions, etc.
However, when we change something that requires user action to maintain compatibility, we will create an issue in this repository labeled **users-read-me**.
Subscribe to this repository updates and issues by clicking the **Watch** button in the top-right corner of this page.
Recent changes requiring user action:

* now: **Work-in-Progress** **MRS UAV System 1.5:** [many changes](https://docs.google.com/document/d/1NibHqNdyzzAYE7DNIMMq1HmzyFrBnISbzV17dP-waYw/edit?usp=sharing)
* January 17, 2023: [Updates for px4 firmware v1.13.2](https://github.com/ctu-mrs/mrs_uav_system/issues/150)
* March 8, 2022: [mrs_lib::Transformer interface updated](https://github.com/ctu-mrs/mrs_uav_system/issues/136)
* December 09, 2021: [not building with --march=native anymore](https://github.com/ctu-mrs/mrs_uav_system/issues/126)
* December 25, 2020: [Updated controller interface, updated thrust curve parametrization](https://github.com/ctu-mrs/mrs_uav_system/issues/33)
* December 15, 2020: [Rework of simulation UAV spawning mechanism, Noetic update](https://github.com/ctu-mrs/mrs_uav_system/issues/32)
* November 12, 2020: [GPS coordinates within Gazebo world need changing](https://github.com/ctu-mrs/mrs_uav_system/issues/22)
* November 12, 2020: [Rangefinder fusion needs enabling in simulation sessions](https://github.com/ctu-mrs/mrs_uav_system/issues/21)

# Disclaimer

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
