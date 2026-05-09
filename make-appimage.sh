#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION="$(sed -n 1p sources.txt)"

export ARCH VERSION
export OUTPATH=./dist
export ICON=$(realpath -e helix.png)
export DESKTOP=$(realpath -e helix.desktop)
export DEPLOY_OPENGL=0
export DEPLOY_PIPEWIRE=0

cp -va hx-* ./AppDir/bin/

chmod +x ./AppDir/bin/hx-*

for PATH_ITEM in ./AppDir/bin/hx-*
do
	ITEM_NAME=$(basename $PATH_ITEM)
	PATH_ITEM_NEW="./AppDir/bin/${ITEM_NAME:3:-3}"
	mv -v "$PATH_ITEM" "$PATH_ITEM_NEW"
done

# Copy details
DET="AppDir/_details"
mkdir -vp "$DET"
echo "$UBID" > "$DET"/commit.txt
echo "$(date)" > "$DET"/date.txt
pacman -Q > "$DET"/packages.txt

# Copy Internal Scripts
cp -v is_details AppDir/bin/details
cp -v is_setup.1.sh AppDir/bin/setup
cat is_setup.2.sh >> AppDir/bin/setup
chmod +x AppDir/bin/details
chmod +x AppDir/bin/setup

# Turn AppDir into AppImage
./quick-sharun.sh --make-appimage

# Archive the AppDir in a TAR
# mv -v AppDir AppDir-"$ARCH"
# tar -cvjf AppDir-"$ARCH".AppImage.tar.xz AppDir-"$ARCH"
