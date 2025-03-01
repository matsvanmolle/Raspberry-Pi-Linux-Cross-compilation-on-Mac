#!/bin/bash
#
# This file should be located at /usr/local/bin/copykernel
#
# The script should also accept environment variables for things that should be
# parameterized (like the Pi's IP address, `kernel8`, etc.). But I'm using it
# for myself right now, so I do what I want.

# Bail on errors
set -e


printf "Setting Config for pi5\n"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig


printf "Compiling\n"
make -j12 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs


printf "Now run: PI_ADDRESS=10.0.100.170 copykernel"
