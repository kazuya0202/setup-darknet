#####################################
# Install Basic (or useful) Command #
#####################################

sudo apt update -y	# update
# apt upgrade -y	# upgrade

sudo apt install -y curl wget sudo

# 'apt-fast' install
sudo /bin/bash -c "$(curl -sL https://git.io/vokNn)"

sudo apt-fast install -y build-essential software-properties-common git htop man unzip vim cmake imagemagick


sudo apt-fast autoremove
sudo apt autoremove
