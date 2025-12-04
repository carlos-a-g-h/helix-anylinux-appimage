#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(cat version)

STEM="helix-$VERSION-$ARCH-linux"
TARFILE="$STEM.tar.xz"
URL_TARFILE="https://github.com/helix-editor/helix/releases/download/$VERSION/$TARFILE"

URL_ICON="https://raw.githubusercontent.com/helix-editor/helix/refs/heads/master/contrib/helix.png"

WMCLASS="helix"

echo "Ensuring Helix ver. $VERSION"
echo "-------------------------------"

if ! [ -d "$STEM" ]
then
	if ! [ -f "$TARFILE" ]
	then
		wget --retry-connrefused --tries=10 "$URL_TARFILE"
	fi
	tar -xf "$STEM.tar.xz"
fi

if [ ! -f "helix.png" ]
then
	wget --retry-connrefused --tries=10 "$URL_ICON"
fi

echo "Creating AppDir beforehand"
echo "--------------------------"

mkdir -vp AppDir/usr/bin/
mkdir -vp AppDir/usr/share/applications/
mkdir -vp AppDir/usr/share/icons/
mkdir -vp AppDir/usr/lib/helix
cp -va "$STEM"/* AppDir/usr/lib/helix/

cp -v helix.desktop AppDir/usr/share/applications/
cp -v helix.png AppDir/usr/share/icons/

echo "X-AppImage-Version=$VERSION" >> AppDir/usr/share/applications/helix.desktop
echo "StartupWMClass=$WMCLASS" >> AppDir/usr/share/applications/helix.desktop

find AppDir

echo "
READY
"

