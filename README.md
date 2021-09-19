# ROS Docker Image

[![gokhlayeh/ros](https://img.shields.io/badge/Docker%20Hub-gokhlayeh%2Fros-blue)](https://hub.docker.com/r/gokhlayeh/ros)
[![Build](https://github.com/ChiefGokhlayeh/ros/actions/workflows/build.yml/badge.svg)](https://github.com/ChiefGokhlayeh/ros/actions/workflows/build.yml)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/ChiefGokhlayeh/ros/master.svg)](https://results.pre-commit.ci/latest/github/ChiefGokhlayeh/ros/master)

A [ROS](https://www.ros.org/) enabled Docker image, used in Autonomous Systems Design Laboratory at University of Esslingen. The image created here is used as base-image for devcontainers in [`asd-docker-template`](https://gitlab.hs-esslingen.de/anbait07/asd-docker-template) of the Autonomous Systems Design course. Its main purpose is to facilitate building of ROS packages via catkin and running simulations in gazebo. Graphical UI elements, such as rviz, are made available through a virtual desktop, hosting a [VNC](https://tigervnc.org/) and [noVNC](https://novnc.com/info.html) endpoint.

## Features

- Full [ROS noetic](http://wiki.ros.org/noetic) distribution based on [Ubuntu Focal Fossa](https://wiki.ubuntu.com/FocalFossa/ReleaseNotes)
  - Including rviz, catkin, CMake, Python + NumPy, and gazebo
- Minimalist virtual desktop based on [Fluxbox](http://fluxbox.org/) available through [VNC](https://tigervnc.org/) (port 5901) and [noVNC](https://novnc.com/info.html) (port 6080)
- Designed as ready-to-use [vscode devcontainer](https://code.visualstudio.com/docs/remote/create-dev-container)

## Usage

While the image can be used to run a standalone ROS application, its actual purpose lies in being utilized as vscode devcontainer. For Dockerfiles, simply point to `gokhlayeh/ros:latest` in the `FROM` directive.

### Dockerfile

Take the following code and put in your `Dockerfile`. You can customize the setup further if you wish.

```Dockerfile
FROM gokhlayeh/ros:latest

# ...
```

### Devcontainer Config

If you develop a ROS package named `my-package`, start with the following `devcontainer.json` file. It will automatically mount your package in a designated workspace and install any dependencies marked `<exec_depend>` through `rosdep`.

```jsonc
{
  "name": "ROS devcontainer for vscode",
  "dockerFile": "Dockerfile",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace/src/my-package,type=bind,consistency=delegated",
  "workspaceFolder": "/workspace/src/my-package",
  "remoteUser": "vscode",
  "postCreateCommand": "rosdep update && sudo apt-get update && rosdep install --from-paths --ignore-src .. -y -r",
  "runArgs": ["--init", "--security-opt", "seccomp=unconfined"],
  "forwardPorts": [6080, 5901],
  "overrideCommand": false
}
```
