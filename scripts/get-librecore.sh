#!/bin/bash

RELEASE=$1
LC=librecore-${RELEASE}

git clone -b ${LC} --single-branch https://github.com/librecore-org/librecore ${LC}
