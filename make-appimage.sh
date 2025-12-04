#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(cat version)
export ARCH VERSION
export OUTPATH=./dist
export ICON=$(realpath -e AppDir/usr/share/icons/helix.png)
export DESKTOP=$(realpath -e AppDir/usr/share/applications/helix.desktop)
export DEPLOY_OPENGL=0
export DEPLOY_PIPEWIRE=0

# Download the quick-sharun.sh script

URL_QSHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

wget --retry-connrefused --tries=30 \
	"$URL_QSHARUN" -O \
	./quick-sharun.sh

chmod +x ./quick-sharun.sh

# Deploy dependencies

./quick-sharun.sh ./AppDir/usr/lib/helix/hx

# Add some extra stuff

if ! [ -d ./AppDir/usr/lib/helix/runtime ]
then
	ln -srv ./AppDir/usr/lib/helix/runtime ./AppDir/bin/runtime
fi

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
