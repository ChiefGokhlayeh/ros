ARG VARIANT=focal
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

ARG ROS_DISTRO=noetic
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    python-is-python3 \
    python3 \
    python3-pip \
    python3-rosdep \
    ros-${ROS_DISTRO}-desktop-full \
    vim-gtk \
    zsh \
    && rm -rf /var/lib/apt/lists/*

ENV ROS_DISTRO=${ROS_DISTRO}
ENV ROS_PYTHON_VERSION=3

RUN rosdep init

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.zsh" >> /etc/zsh/zshrc

COPY library-scripts/desktop-lite-debian.sh /tmp/library-scripts/
RUN apt-get update \
    && bash /tmp/library-scripts/desktop-lite-debian.sh \
    && rm -rf /var/lib/apt/lists/*
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:" DISPLAY=":1" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/local/share/desktop-init.sh", "/entrypoint.sh"]
CMD ["sleep", "infinity"]
