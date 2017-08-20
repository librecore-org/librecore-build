#!/bin/bash

COREBOOT_RELEASE=$1

wget -c https://coreboot.org/releases/coreboot-${COREBOOT_RELEASE}.tar.xz

#gpg --verify coreboot-${COREBOOT_RELEASE}.tar.xz.sig
