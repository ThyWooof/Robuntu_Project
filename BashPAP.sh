#!/bin/bash
set -e

# --- Source ROS environment ---
echo "Sourcing ROS Noetic environment..."
if [ -f "/opt/ros/noetic/setup.bash" ]; then
  source /opt/ros/noetic/setup.bash
else
  echo "ROS Noetic not found at /opt/ros/noetic. Please ensure it's installed."
  exit 1
fi

# --- Docker Installation ---
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# --- MRS UAV Dependencies ---
echo "Installing MRS UAV dependencies..."
sudo apt install -y \
  git cmake build-essential python3-pip \
  python3-catkin-tools python3-rosdep \
  python3-rosinstall python3-rosinstall-generator \
  python3-wstool libgflags-dev libgoogle-glog-dev

# --- Initialize rosdep ---
sudo rosdep init 2>/dev/null || echo "rosdep already initialized"
rosdep update

# --- Setup workspace ---
echo "Setting up catkin workspace..."
mkdir -p ~/mrs_workspace/src
cd ~/mrs_workspace/src

# --- Clone MRS UAV System ---
if [ ! -d "mrs_uav_system" ]; then
  git clone --recurse-submodules https://github.com/ctu-mrs/mrs_uav_system.git
else
  echo "MRS UAV system already cloned."
fi

cd ~/mrs_workspace
rosdep install --from-paths src --ignore-src -r -y

# --- Source ROS again in case it's lost ---
source /opt/ros/noetic/setup.bash

# --- Build using Catkin Tools ---
echo "Building the workspace..."
catkin config --extend /opt/ros/noetic
catkin init || echo "Catkin workspace already initialized"
catkin build

echo "MRS UAV setup complete."

echo "✅ Post-installation complete. You may now reboot or proceed with further setup." 