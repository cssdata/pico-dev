# pico-dev

A RP2040 / RP2350 dev-container

## start the container in your working directory, then log into the container

- docker run -d -it --rm --name pico --mount type=bind,source=${PWD},target=/workspace pico-sdk
- docker exec -it pico /bin/bash

### You can set the board (pico, picow, pico2) and chip ()

### This is just under development, there will be a meaningful README when we are at v1.0 [2025-03-26 cs]

## Get Started

The Easy way to get started:

- Build the container on your platform:
- Check out the sample at https://github.com/cssdata/pico-sample and follow the instructions
