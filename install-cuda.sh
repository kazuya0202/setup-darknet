##########################
# INSTALL CUDA ON UBUNTU #
##########################

#LOCATION OF INSTALL

INSTALL_LOCATION='$HOME'


# 0. PREPARE TO INSTALL

# Install 'apt-fast'
# /bin/bash -c "$(curl -sL https://git.io/vokNn)"

# Move to ${INSTALL_LOCATION}
cd ${INSTALL_LOCATION}


# 1. KEEP UBUNTU OR DEBIAN UP TO DATE

sudo apt-fast -y update
# sudo apt-fast -y upgrade       # Uncomment this line to install the newest versions of all packages currently installed
# sudo apt-fast -y dist-upgrade  # Uncomment this line to, in addition to 'upgrade', handles changing dependencies with new versions of packages
# sudo apt-fast -y autoremove    # Uncomment this line to remove packages that are now no longer needed


# 2. INSTALL THE DEPENDENCIES

# Build tools:
sudo apt-fast install -y build-essential cmake


# 3. INSTALL THE LIBRARY

# CUDA:
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo apt-fast update -y

sudo apt-fast install -y cuda-10-0

rm cuda-repo-ubuntu1804_10.0.130-1_amd64.deb

echo 'export PATH=/usr/local/cuda-10.0/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc

. ~/.bashrc


# sudo reboot
# nvcc --version




# CUDA:
# https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

# cuDNN:
# aria2c -x5 https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.6.0.64/prod/10.0_20190516/cudnn-10.0-linux-x64-v7.6.0.64.tgz


# tar -xzvf cudnn-10.0-linux-x64-v7.6.0.64.tgz
# sudo cp -a cuda/lib64/* /usr/lib/cuda/lib64/
# sudo cp -a cuda/include/* /usr/lib/cuda/include/
# # sudo ldconfig

# . ~/.bashrc
