FROM nvidia/cuda:12.0.0-cudnn8-devel-ubuntu18.04
LABEL maintainer="Tabish Rashid"

# CUDA includes
ENV CUDA_PATH=/usr/local/cuda
ENV CUDA_INCLUDE_PATH=/usr/local/cuda/include
ENV CUDA_LIBRARY_PATH=/usr/local/cuda/lib64

# Ubuntu Packages
RUN apt-get update -y && apt-get install software-properties-common -y && \
    add-apt-repository -y multiverse && apt-get update -y && apt-get upgrade -y && \
    apt-get install -y apt-utils nano vim man build-essential wget sudo && \
    rm -rf /var/lib/apt/lists/*

# Install curl and other dependencies
RUN apt-get update -y && apt-get install -y curl libssl-dev openssl libopenblas-dev \
    libhdf5-dev hdf5-helpers hdf5-tools libhdf5-serial-dev libprotobuf-dev protobuf-compiler git && \
    ln -s /usr/bin/add-apt-repository /usr/bin/python-software-properties
RUN apt-get update && apt-get install -y equivs && \
    echo "Package: python-software-properties\nProvides: python-software-properties\nPriority: optional\nVersion: 1.0" > python-software-properties-control && \
    equivs-build python-software-properties-control && \
    dpkg -i python-software-properties_1.0_all.deb && \
    rm python-software-properties-control python-software-properties_1.0_all.deb && \
    curl -sk https://raw.githubusercontent.com/torch/distro/master/install-deps | bash && \
    rm -rf /var/lib/apt/lists/*

# Install python3 pip3
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install python3-dev
RUN pip3 install --upgrade pip

# Python packages we use (or used at one point...)
RUN pip3 install numpy scipy pyyaml matplotlib
RUN pip3 install imageio
RUN pip3 install tensorboard-logger
RUN pip3 install pygame

RUN mkdir /install
WORKDIR /install

RUN pip3 install jsonpickle==0.9.6
# install Sacred (from OxWhirl fork)
RUN pip3 install setuptools
RUN git clone https://github.com/oxwhirl/sacred.git /install/sacred && cd /install/sacred && python3 setup.py install

#### -------------------------------------------------------------------
#### install pytorch
#### -------------------------------------------------------------------
RUN pip3 install torch
RUN pip3 install torchvision snakeviz pytest probscale

## -- SMAC
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget build-essential && \
    wget https://github.com/Kitware/CMake/releases/download/v3.27.7/cmake-3.27.7-linux-x86_64.sh && \
    sh cmake-3.27.7-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-3.27.7-linux-x86_64.sh

RUN pip3 install dm-tree
RUN pip3 install git+https://github.com/oxwhirl/smac.git
ENV SC2PATH=/pymarl/3rdparty/StarCraftII

WORKDIR /pymarl
