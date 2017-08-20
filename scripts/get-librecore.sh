#!/bin/bash
RELEASE=$1

git clone -b librecore-${RELEASE} --single-branch https://github.com/librecore-org/librecore librecore-${RELEASE}
