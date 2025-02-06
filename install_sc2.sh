#!/bin/bash

# Bash Colors
declare -A colors

colors[light_blue]="\e[94m"
colors[light_cyan]="\e[96m"
colors[light_green]="\e[92m"
colors[light_red]="\e[91m"
colors[reset]="\e[0m"

hello_world() {
    echo -e "${colors[light_blue]}************************${colors[reset]}"
    echo -e "${colors[light_cyan]}Have a great $(date +'%A')!${colors[reset]}"
    echo -e "${colors[light_blue]}************************${colors[reset]}"
}

hello_world

echo -e "${colors[light_green]}Setting up directories...${colors[reset]}"
readonly CUR_DIR=$(cd $(dirname "$0") && pwd)
readonly THIRD_PARTY_DIR="${CUR_DIR}/3rdparty/"
readonly SC2PATH="${THIRD_PARTY_DIR}/StarCraftII/"
readonly MAP_DIR="${SC2PATH}/Maps/"

echo -e "${colors[light_green]}Creating 3rdparty directory...${colors[reset]}"
mkdir -p $THIRD_PARTY_DIR && cd $THIRD_PARTY_DIR

# Install SC2 and add the custom maps
if [ ! -d $SC2PATH ]; then
    echo "StarCraftII is not installed. Installing now ..."
    wget http://blzdistsc2-a.akamaihd.net/Linux/SC2.4.10.zip
    unzip -P iagreetotheeula SC2.4.10.zip
    rm -rf SC2.4.10.zip
else
    echo 'StarCraftII is already installed.'
fi

echo "Adding SMAC maps. MAP_DIR is set to ${MAP_DIR}"

if [ ! -d $MAP_DIR ]; then
    mkdir -p $MAP_DIR
fi

cd ..
wget https://github.com/oxwhirl/smac/releases/download/v0.1-beta1/SMAC_Maps.zip
unzip SMAC_Maps.zip
mv SMAC_Maps $MAP_DIR
rm -rf SMAC_Maps.zip

echo 'StarCraft II and SMAC are installed.'
