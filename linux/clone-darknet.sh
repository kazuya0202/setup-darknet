#################
# CLONE DARKNET #
#################

# Clone Repository
git clone https://github.com/alexeyAB/darknet.git
cd darknet

mv Makefile Makefile-old

curl https://raw.githubusercontent.com/kazuya0202/Makefile-for-darknet/master/Makefile > ./Makefile