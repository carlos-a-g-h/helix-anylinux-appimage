#!/bin/bash

# Installs the software inside the compressed AppDir

set -eux

NAME="Helix"
FILEPATH="$1"

echo "[RUN] $NAME : $FILEPATH"

FILE_DESKTOP="helix.desktop"
FILE_ICON="helix.png"
BIN_APPDIR="bin/hx"
BIN_ABS="/usr/bin/hx"

# Decompress the AppDIr
unsquashfs -f -d "$NAME" "$FILEPATH"

# Move contents of the AppDir to the appimages directory
APPIMAGE_DIR="/usr/appimages/""$NAME"
if [ -d "$APPIMAGE_DIR" ]
then
	rm -vrf "$APPIMAGE_DIR"
	echo "[NOTICE] WIPED OUT: $APPIMAGE_DIR"
else
	mkdir -vp /usr/appimages/
fi
mv -vf "$NAME" /usr/appimages/

# Link the main binary to the system
ln -srf "$APPIMAGE_DIR"/"$BIN_APPDIR" "$BIN_ABS"

# Copy desktop file
cp -va "$APPIMAGE_DIR"/"$FILE_DESKTOP" /usr/share/applications/

# Copy icon file
cp -va "$APPIMAGE_DIR"/"$FILE_ICON" /usr/share/icons/

# Move the config (and backup any old config)
CONFIG_DIR="$HOME""/.config/helix"
CONFIG_DIR_BAK="$HOME""/.config/helix.bak"
if [ -d "$CONFIG_DIR" ]
then	
	mv -v "$CONFIG_DIR" "$CONFIG_DIR_BAK"
	echo "[NOTICE] BACKED UP: $CONFIG_DIR_BAK"
	mkdir -v "$CONFIG_DIR"
fi
mv -vf "$APPIMAGE_DIR"/_config/* "$CONFIG_DIR"/

# Destroy the compressed AppDir file
rm -v "$FILEPATH"

# ALl good
echo "[OK] Installed: $NAME"
