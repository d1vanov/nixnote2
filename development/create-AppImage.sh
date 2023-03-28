#!/bin/bash

PROG=nixnote2

BUILD_DIR=$(cat _build_dir_.txt)
echo Build dir: ${BUILD_DIR}

export VERSIONX=$(cat appdir/usr/share/nixnote2/version.txt)
echo Version: ${VERSIONX}

CMD="linuxdeployqt -v0 --appdir appdir"
echo About to run: $CMD
$CMD
