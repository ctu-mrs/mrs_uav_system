ARG BASE_IMAGE=ctumrs/ros_jazzy:latest
ARG PPA_VARIANT=unstable

FROM ${BASE_IMAGE}

ARG PPA_VARIANT

# workaround interractive prompts during apt installations and install the MRS UAV System
RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections && \
    apt-get -y update && curl https://ctu-mrs.github.io/ppa2-${PPA_VARIANT}/add_ppa.sh | bash && \
    apt-get --no-install-recommends -y install ros-jazzy-mrs-uav-system-full \
    ros-jazzy-mavros-extras gdb keyboard-configuration software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/ros_entrypoint.sh"]
