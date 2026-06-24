ARG PPA_VARIANT=unstable
ARG BASE_IMAGE=ctumrs/ros_jazzy:latest

FROM ${BASE_IMAGE}

ARG PPA_VARIANT

# workaround interractive prompts during apt installations and install the MRS UAV System
RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections && \
    apt-get update && curl https://ctu-mrs.github.io/ppa2-${PPA_VARIANT}/add_ppa.sh | bash && \
    apt-get --no-install-recommends -y install ros-${ROS_DISTRO}-mrs-uav-system \
    ros-${ROS_DISTRO}-mavros-extras gdb keyboard-configuration software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/ros_entrypoint.sh"]
