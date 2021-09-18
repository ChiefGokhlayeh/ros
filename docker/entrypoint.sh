#!/usr/bin/env bash
set -e

source /opt/ros/$ROS_DISTRO/setup.bash

sudo chown vscode:vscode /workspace /workspace/src

mkdir -p /workspace/src && ([ -f /workspace/src/CMakeLists.txt ] || catkin_init_workspace /workspace/src)

exec "$@"
