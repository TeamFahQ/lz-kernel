#!/bin/bash

# Colorizing the make.sh
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
txtbld=$(tput bold)             # Bold
txtrst=$(tput sgr0)             # Reset

# Cleans the terminal window
reset

# Number of cores to be used
export CONCURRENCY_LEVEL=$(nproc --all)
echo "${bldblu}${txtbld}Using $CONCURRENCY_LEVEL cores${txtrst}"

# Compile it
make oldconfig && make prepare
time make deb-pkg -j $(nproc --all)

# Saving the new build config
if [ ! -d "configs" ];
then
mkdir ./configs && echo "${bldred}${txtbld}Created configs directory to store config file${txtrst}"
fi
cp .config configs/.config
