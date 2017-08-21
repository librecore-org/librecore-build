#!/bin/bash

RELEASE=$1
LC=librecore-${RELEASE}

git clone https://github.com/librecore-org/microcode.git

# We consider signed CPU microcode updates as essential errata to silicon
# therefore we include it in Librecore builds
mkdir -p ${LC}/3rdparty/blobs/cpu
cp -a microcode/intel ${LC}/3rdparty/blobs/cpu
cp -a microcode/amd ${LC}/3rdparty/blobs/cpu
rm -fr microcode
