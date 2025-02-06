#!/bin/bash
readonly GPU=0
readonly HASH=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)
readonly NAME=${USER}_pymarl_GPU_${GPU}_${HASH}

echo "Launching container named '${name}' on GPU '${GPU}'"

# TODO: Add argument `--runtime=nvidia` to `docker run`
#       once Dockerfile image is updated to Cuda v.12.8

# Launches a docker container using our image, and runs the provided command
NV_GPU="$GPU" docker run \
  --name $NAME \
  --user $(id -u):$(id -g) \
  -v `pwd`:/pymarl \
  -t pymarl:1.0 \
  ${@:1}
