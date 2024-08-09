#!/usr/bin/env bash
set -euxo pipefail

if [[ "$CROSS_TARGET" == "aarch64-unknown-linux-gnu" ]]; then
  apt-get update && apt-get install --assume-yes libssl-dev build-essential

  sed 's/^deb http/deb [arch=amd64] http/' -i '/etc/apt/sources.list'
  echo 'deb [arch=arm64] http://archive.ubuntu.com/pub/ubuntu/ports jammy main restricted universe multiverse' >> /etc/apt/sources.list
  echo 'deb [arch=arm64] http://archive.ubuntu.com/pub/ubuntu/ports jammy-updates main restricted universe multiverse' >> /etc/apt/sources.list
  echo 'deb [arch=arm64] http://archive.ubuntu.com/pub/ubuntu/ports jammy-backports main restricted universe multiverse' >> /etc/apt/sources.list

  dpkg --add-architecture $CROSS_DEB_ARCH
  apt-get update && apt-get install --assume-yes libssl-dev:$CROSS_DEB_ARCH pkg-config:$CROSS_DEB_ARCH
fi
