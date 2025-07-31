#!/bin/bash
set -e

# Example build script for FriendlyWrt 24.10.x on NanoPi R3S
# This script fetches FriendlyWrt, adds feeds for Rockchip MPP
# and builds several multimedia packages.

FRIENDLYWRT_BRANCH="master-v24.10"
FRIENDLYWRT_REPO="https://github.com/friendlyarm/friendlywrt.git"
RKMPP_FEED="https://github.com/jjm2473/openwrt-rkmpp.git"

WORKDIR=${WORKDIR:-$PWD/friendlywrt}

# Clone FriendlyWrt if not present
if [ ! -d "$WORKDIR" ]; then
    git clone --depth 1 -b "$FRIENDLYWRT_BRANCH" "$FRIENDLYWRT_REPO" "$WORKDIR"
fi
cd "$WORKDIR"

# Add rockchip feed if missing
if ! grep -q openwrt-rkmpp feeds.conf.default; then
    echo "src-git rkmpp $RKMPP_FEED" >> feeds.conf.default
fi

./scripts/feeds update -a
./scripts/feeds install rockchip-mpp gstreamer-rockchip \
    gstreamer1-plugins-good gstreamer1-libav

# Default config for NanoPi R3S (aarch64_generic)
# You may replace this with a custom .config
make defconfig

# Build requested packages
make package/rockchip-mpp/compile -j$(nproc) V=s
make package/gstreamer-rockchip/compile -j$(nproc) V=s
make package/gstreamer1-plugins-good/compile -j$(nproc) V=s
make package/gstreamer1-libav/compile -j$(nproc) V=s

# Final packages will be in bin/packages/*
