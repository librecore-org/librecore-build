#!/bin/bash

make distclean
./util/abuild/abuild -A -z -p none -c j4 --timeless
