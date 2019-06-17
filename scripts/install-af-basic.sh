apt update -y	# update
# apt upgrade -y

apt install -y curl wget sudo

# 'apt-fast' install
/bin/bash -c "$(curl -sL https://git.io/vokNn)"

apt-fast install -y build-essential software-properties-common byobu git htop man unzip vim cmake