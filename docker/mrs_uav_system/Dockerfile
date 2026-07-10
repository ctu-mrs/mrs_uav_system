ARG PPA_VARIANT=unstable
ARG BASE_IMAGE=ctumrs/mrs_uav_system_core:${PPA_VARIANT}

FROM ${BASE_IMAGE}

RUN apt-get update && apt-get --no-install-recommends -y install ros-${ROS_DISTRO}-mrs-uav-system-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/ros_entrypoint.sh"]
