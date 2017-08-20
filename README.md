librecore-build
===============

This is a set of build scripts to compile librecore roms.

Instructions for obtaining source code
======================================

There are two options for obtaining the source code:

The following command will download a coreboot release and deblob the source:

* `make get-deblob-coreboot`

The following command will clone the same deblobbed code from a git repository:

* `make get-dev-librecore`


Toolchain/Compilers
===================

To simplify the build process,
this project provides a precompiled cross compiled toolchain for the Fedora distro:

* `sudo dnf copr enable damo22/librecore-xgcc`
* `sudo dnf install librecore-xgcc`

TODO: Obviously not everyone uses Fedora, so you may build your own toolchain if you wish using coreboot's crossgcc.


Instructions for building a rom
===============================

Ensure that your cross toolchain is in your environment working path:
For the provided Fedora package that would be:

* `export PATH=${PATH}:/opt/xgcc-{version}/bin`

In the following command, replace vendor/model with the desired board:
* `make BOARD=vendor/model rom`

A rom should appear in `./build/VENDOR_BOARD/coreboot.rom`


Test-building all possible roms
===============================

* `make test-all`


Caveats
=======

This is still a work in progress.  Payloads need to be inserted manually
into the rom with cbfstool, and some roms need special layout files to ensure
you don't overwrite existing critial firmware such as Management Engine partitions and the Intel Flash Descriptor (IFD).

DO NOT FLASH `./build/VENDOR_MODEL/coreboot.rom` directly to your device.  There is currently a 100% chance of bricking your device since there are no payloads yet.

You have been warned!
