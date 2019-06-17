########################################
# A. Install Basic (or useful) Command #
########################################
# ./scripts/install-af-basic.sh

apt update -y	# update
# apt upgrade -y

apt install -y curl wget sudo

# 'apt-fast' install
/bin/bash -c "$(curl -sL https://git.io/vokNn)"

apt-fast install -y build-essential software-properties-common byobu git htop man unzip vim cmake imagemagick


###########################
# B. Set Up NVIDIA Driver #
###########################
# ./scripts/install-nvidia-driver.sh

apt-fast install -y nvidia-340 libnvidia-cfg1-390 libnvidia-common-390 libnvidia-compute-390 libnvidia-decode-390 libnvidia-encode-390 libnvidia-fbc1-390 libnvidia-gl-390 libnvidia-ifr1-390 nvidia-dkms-390 nvidia-driver-390 nvidia-kernel-common-390 nvidia-kernel-source-390 nvidia-modprobe nvidia-opencl-dev nvidia-settings nvidia-utils-390 xserver-xorg-video-nvidia-390

apt-fast autoremove
apt autoremove