#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION="$(sed -n 1p sources.txt)"

UBID="$1"
UBID_SHORT="${UBID:0:8}"

NAME="Helix"
APPIMAGE_STEM="$NAME"_v"$VERSION"_"$UBID_SHORT"_anylinux_"$ARCH"

export ARCH VERSION
export OUTPATH=./dist
export ICON=$(realpath -e helix.png)
export DESKTOP=$(realpath -e helix.desktop)
export OUTNAME="$APPIMAGE_STEM".AppImage

export DEPLOY_OPENGL=0
export DEPLOY_PIPEWIRE=0

# Deploy dependencies
./quick-sharun.sh extracted/helix-editor/hx

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

# Copy the internal scripts that are specific for Helix
cp -va hx-* ./AppDir/bin/
chmod +x ./AppDir/bin/hx-*
for PATH_ITEM in ./AppDir/bin/hx-*
do
	ITEM_NAME=$(basename $PATH_ITEM)
	PATH_ITEM_NEW="./AppDir/bin/${ITEM_NAME:3:-3}"
	mv -v "$PATH_ITEM" "$PATH_ITEM_NEW"
done

# Turn AppDir into AppImage
./quick-sharun.sh --make-appimage

# Archive the AppDir in a SQUASHFS file
mksquashfs AppDir "$APPIMAGE_STEM".AppImage.squashfs -comp xz
# mv -v AppDir AppDir-"$ARCH"
# tar -cvjf AppDir-"$ARCH"-AppImage.tar.xz AppDir-"$ARCH"
