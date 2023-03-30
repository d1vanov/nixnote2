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

# First, create appdir with bundled binaries
CMD="linuxdeploy --desktop-file=$DESKTOP_FILE --appdir=appdir --plugin qt"
echo About to run: $CMD
$CMD

# Some libs from libnss3 package are not bundled so they need to be copied
# into the appdir manually
cp -n /usr/lib/x86_64-linux-gnu/libfreebl3.so appdir/usr/lib
cp -n /usr/lib/x86_64-linux-gnu/libfreeblpriv3.so appdir/usr/lib
cp -n /usr/lib/x86_64-linux-gnu/libnss3.so appdir/usr/lib
cp -n /usr/lib/x86_64-linux-gnu/libnssutil3.so appdir/usr/lib
cp -n /usr/lib/x86_64-linux-gnu/libsmime3.so appdir/usr/lib
cp -n /usr/lib/x86_64-linux-gnu/libssl3.so appdir/usr/lib

mkdir -p appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libfreebl3.chk appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libfreebl3.so appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libfreeblpriv3.chk appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libfreeblpriv3.so appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libnssckbi.so appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libnssdbm3.chk appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libnssdbm3.so appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libsoftokn3.chk appdir/usr/lib/nss
cp -n /usr/lib/x86_64-linux-gnu/nss/libsoftokn3.so appdir/usr/lib/nss

# Working around the issue with OpenSSL: Ubuntu 20.04 provides OpenSSL 1.1 libraries
# but starting with Ubuntu 22.04 only OpenSSL 3.x and higher versions are provided.
# linuxdeploy doesn't deploy OpenSSL libraries because it is presumed that these should
# be provided by the distro as they might need to be updated independently from
# AppImages, especially if security vulnerabilities are discovered and patched.
# However, if OpenSSL 1.1 libraries are not included, OAuth in Nixnote2 just doesn't
# work. So choosing the lesser or evils, bundling OpenSSL libraries into the AppImage
# manually.
# echo "Copying OpenSSL libs"
cp /lib/x86_64-linux-gnu/libcrypt.so.1 appdir/usr/lib/
cp /lib/x86_64-linux-gnu/libcrypt.so.1.1.0 appdir/usr/lib/
cp /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 appdir/usr/lib
cp /usr/lib/x86_64-linux-gnu/libssl.so.1.1 appdir/usr/lib

# Now create the actual appimage
echo "Creating AppImage"
appimagetool -n appdir
