# Use Debian slim as the base image
FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    git \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    libstdc++-arm-none-eabi-newlib \
    libusb-1.0-0-dev \
    libncurses5-dev \
    libncursesw5-dev \
    wget \
    unzip \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install -y \
    libtool \
    pkg-config \
    autoconf \
    automake \
    gdb-multiarch

# Install the Pico SDK
ARG PICO_SDK_PATH=/usr/local/pico-sdk
RUN git clone -b master https://github.com/raspberrypi/pico-sdk.git ${PICO_SDK_PATH} && \
    cd ${PICO_SDK_PATH} && \
    git submodule update --init
# Set environment variables
ENV PICO_SDK_PATH=${PICO_SDK_PATH}

# Install OpenOCD for debugging
ARG OPENOCD_PATH=/usr/local/openocd
RUN git clone https://github.com/raspberrypi/openocd.git ${OPENOCD_PATH} && \
    cd ${OPENOCD_PATH} && \
    ./bootstrap && \
    ./configure --enable-sysfsgpio --enable-bcm2835gpio && \
    make && \
    make install clean

# Install the picotool
ARG PICOTOOL_PATH=/usr/local/picotool
RUN git clone https://github.com/raspberrypi/picotool.git ${PICOTOOL_PATH} && \
    cd ${PICOTOOL_PATH} && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install clean

# FreeRTOS
ARG FREERTOS_PATH=/usr/local/freertos
RUN git clone --depth 1 --branch V11.0.1 https://github.com/FreeRTOS/FreeRTOS-Kernel ${FREERTOS_PATH} && \
    cd ${FREERTOS_PATH} && \
    git submodule update --init --recursive
ENV FREERTOS_KERNEL_PATH=${FREERTOS_PATH}

# Set up the working directory
WORKDIR /workspace

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
