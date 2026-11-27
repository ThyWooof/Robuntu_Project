# Robuntu setup walkthrough

This guide explains the current `BashPAP.sh` script for learning and review. It is not a claim that the script has been tested on a clean machine.

## Before you run it

The script expects:

- Ubuntu 20.04.6 Desktop amd64 (identified in the Cubic screenshot) with ROS Noetic installed at `/opt/ros/noetic`
- Internet access to Ubuntu, Docker, ROS, and GitHub repositories
- A user account that can run commands with `sudo`
- An `amd64` system for the Docker repository line used by the script

Use a disposable virtual machine first. The script changes apt sources, installs packages, downloads source code, and builds software. Read every command before running it on a machine that matters.

## What each section does

### 1. Fail early and load ROS

`set -e` tells Bash to stop when most commands fail. The script then checks for `/opt/ros/noetic/setup.bash` and sources it. If that file is missing, the script exits with an error. ROS Noetic must therefore be installed before this script starts.

### 2. Add the Docker package source

The script downloads Docker's signing key, adds the Ubuntu Focal package repository, refreshes apt metadata, and installs Docker Engine packages. The repository line is pinned to `focal` and `amd64`; it is not a generic configuration for every Ubuntu release or CPU architecture.

The key setup uses `apt-key`. Before adapting this section, compare it with Docker's current official installation instructions for the target Ubuntu release.

### 3. Install build tools and ROS dependencies

The script installs Git, CMake, a compiler toolchain, Python pip, catkin tools, rosdep, rosinstall tools, and several libraries used by robotics software.

### 4. Initialize rosdep

`rosdep init` is attempted, and any error is treated as if rosdep were already initialized. That can hide errors other than the already-initialized case. `rosdep update` then downloads the dependency metadata.

### 5. Create and populate the workspace

The script creates `~/mrs_workspace/src`. If that folder does not already contain `mrs_uav_system`, it clones the upstream project with its Git submodules. If the folder already exists, the script leaves it as-is; it does not fetch or update it.

### 6. Install dependencies and build

From the workspace, `rosdep install` installs dependencies for the source tree. The script sources ROS again, configures catkin to extend `/opt/ros/noetic`, initializes the workspace if needed, and runs `catkin build`.

## Run command

After reviewing the script and confirming the prerequisites:

```bash
bash BashPAP.sh
```

The run may take a while and requires a working network connection. Save the terminal output when testing so the README can record the Ubuntu version, hardware or VM details, date, and whether the full build succeeded.

## What would make this more reproducible

- Record the exact Ubuntu image release and architecture.
- Pin or record versions for Docker, ROS packages, and the MRS UAV source revision.
- Replace the Focal-only repository setup if newer Ubuntu versions are intended.
- Handle the rosdep initialization error explicitly instead of treating every error as success.
- Record a clean-VM run, including failures and fixes.
- Document how the ISO itself was assembled; that process is not automated in this repository today.