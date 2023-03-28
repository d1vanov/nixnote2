#!/bin/bash

PROG=nixnote2

BUILD_DIR=$(cat _build_dir_.txt)
echo Build dir: ${BUILD_DIR}

export VERSIONX=$(cat appdir/usr/share/nixnote2/version.txt)
echo Version: ${VERSIONX}

export DEBUG=1
CMD="linuxdeployqt --appdir appdir"
echo About to run: $CMD
$CMD
