#!/bin/bash

# This script uninstalls the official QtWebKit packages and instead unpacks custom
# QtWebKit binaries into the locations where build and deploy system would pick them

CUSTOM_WEBKIT_BINARIES_FOLDER=${1}

if [ -z "${CUSTOM_WEBKIT_BINARIES_FOLDER}" ]; then
    echo "Cannot replace the official QtWebKit with custom binaries: no path to custom binaries folder"
    exit 1
fi

echo "Removing the official QtWebKit packages"
apt-get remove --purge -y libqt5webkit5-dev libqt5webkit5

echo "Copying custom QtWebKit headers"
mkdir -p /usr/include/x86_64-linux-gnu/qt5
cp -r ${CUSTOM_WEBKIT_BINARIES_FOLDER}/include/* /usr/include/x86_64-linux-gnu/qt5/

echo "Copying custom QtWebKit libs"
cp -r ${CUSTOM_WEBKIT_BINARIES_FOLDER}/lib/* /usr/lib/x86_64-linux-gnu/

echo "Copying custom QtWebKit libexec files"
mkdir -p /usr/include/x86_64-linux-gnu/qt5/libexec
cp -r ${CUSTOM_WEBKIT_BINARIES_FOLDER}/libexec/* /usr/lib/x86_64-linux-gnu/qt5/libexec/

echo "Copying custom QtWebKit mkspecs files"
mkdir -p /usr/include/x86_64-linux-gnu/qt5/mkspecs
cp -r ${CUSTOM_WEBKIT_BINARIES_FOLDER}/mkspecs/* /usr/include/x86_64-linux-gnu/qt5/mkspecs/
