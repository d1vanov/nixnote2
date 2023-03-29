#!/bin/bash

# This script uninstalls the official QtWebKit packages and instead unpacks custom
# QtWebKit binaries into the locations where build and deploy system would pick them

CUSTOM_WEBKIT_BINARIES_FOLDER=${1}

if [ -z "${CUSTOM_WEBKIT_BINARIES_FOLDER}" ]; then
    echo "Cannot replace the official QtWebKit with custom binaries: no path to custom binaries folder"
    exit 1
fi

echo "Removing the files from official QtWebKit packages"
rm -rf /usr/include/x86_64-linux-gnu/qt5/QtWebKit
rm -rf /usr/include/x86_64-linux-gnu/qt5/QtWebKitWidgets
rm -rf /usr/lib/x86_64-linux-gnu/cmake/Qt5WebKit
rm -rf /usr/lib/x86_64-linux-gnu/cmake/Qt5WebKitWidgets
rm -rf /usr/lib/x86_64-linux-gnu/libQt5WebKit.so*
rm -rf /usr/lib/x86_64-linux-gnu/libQt5WebKitWidgets.so*
rm -rf /usr/lib/x86_64-linux-gnu/pkgconfig/Qt5WebKit.pc
rm -rf /usr/lib/x86_64-linux-gnu/pkgconfig/Qt5WebKitWidgets.pc
rm -rf /usr/lib/x86_64-linux-gnu/qt5/mkspecs/modules/qt_lib_webkit.pri
rm -rf /usr/lib/x86_64-linux-gnu/qt5/mkspecs/modules/qt_lib_webkitwidgets.pri
rm -rf /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebNetworkProcess
rm -rf /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebPluginProcess
rm -rf /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebProcess
rm -rf /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebStorageProcess

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

echo "Copying done. New QtWebKit files:"
ls -la /usr/include/x86_64-linux-gnu/qt5/QtWebKit
ls -la /usr/include/x86_64-linux-gnu/qt5/QtWebKitWidgets
ls -la /usr/lib/x86_64-linux-gnu/cmake/Qt5WebKit
ls -la /usr/lib/x86_64-linux-gnu/cmake/Qt5WebKitWidgets
ls -la /usr/lib/x86_64-linux-gnu/pkgconfig/Qt5WebKit.pc
ls -la /usr/lib/x86_64-linux-gnu/pkgconfig/Qt5WebKitWidgets.pc
ls -la /usr/lib/x86_64-linux-gnu/qt5/mkspecs/modules/qt_lib_webkit.pri
ls -la /usr/lib/x86_64-linux-gnu/qt5/mkspecs/modules/qt_lib_webkitwidgets.pri
ls -la /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebNetworkProcess
ls -la /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebPluginProcess
ls -la /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebProcess
ls -la /usr/lib/x86_64-linux-gnu/qt5/libexec/QtWebStorageProcess
rm -rf /usr/lib/x86_64-linux-gnu/libQt5WebKit.so*
rm -rf /usr/lib/x86_64-linux-gnu/libQt5WebKitWidgets.so*
