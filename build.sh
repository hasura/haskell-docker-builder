#!/bin/bash
set -ex

ldd /root/$1 | awk 'BEGIN{ORS="\n"}$1~/^\//{print $1}$3~/^\//{print $3}' | xargs cp -L --parents -t rootfs/
cp /root/$1 rootfs/bin/
tar -cC rootfs .
