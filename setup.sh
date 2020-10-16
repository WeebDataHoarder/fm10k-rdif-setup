#!/bin/bash

# rdif-6.0.10.7.30.1.tar.gz
RDIF_URL="https://ipfs.io/ipfs/QmaHSRgZ9obFZPM3e64j7tzqKGtUq6utHS47URfM4kWRxe"

set -e

SCRIPT_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

pushd "${SCRIPT_DIR}"

pushd src

pushd fm10k/src
make clean
make -j $(nproc) CONFIG_UIO=1
make install CONFIG_UIO=1
popd

if [ ! -d rdif ] || [ "${RDIF_URL}" != "$(cat rdif/.rdif_fetched_url 2>/dev/null)" ]; then
  rm -rf "rdif"
  wget -4 "${RDIF_URL}"  -O - | tar zxf -
  mv "rdif-"* "rdif"
  echo "${RDIF_URL}" > rdif/.rdif_fetched_url
  touch rdif/.keep
fi

pushd rdif
./clean
./install
popd

rdif stop
modprobe uio
#Reload FM10K kernel module
rmmod fm10k
modprobe fm10k

popd

if [ ! -d /etc/rdi ]; then
  mkdir /etc/rdi
fi

if [ ! -f /etc/rdi/fm_platform_attributes.cfg ]; then
  cp -v platform/default/fm_platform_attributes.cfg /etc/rdi/fm_platform_attributes.cfg
fi