#!/bin/bash

PROG=nixnote2
DESKTOP_FILE=appdir/usr/share/applications/${PROG}.desktop

BUILD_DIR=$(cat _build_dir_.txt)
echo Build dir: ${BUILD_DIR}

if [ ! -f "$DESKTOP_FILE" ]; then
    echo "$DESKTOP_FILE not found!"
    exit 1
fi

export VERSIONX=$(cat appdir/usr/share/nixnote2/version.txt)
echo Version: ${VERSIONX}

export DEBUG=1

CMD="linuxdeploy --desktop-file=$DESKTOP_FILE --appdir=appdir"
echo About to run: $CMD
$CMD

CMD="linuxdeployqt --appdir=appdir"
echo About to run: $CMD
$CMD
