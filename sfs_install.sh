#!/bin/bash

# Installs the software inside the compressed AppDir to the system

set -eux

NAME="Helix"
FILEPATH="$1"

echo "Integrating: $NAME : $FILEPATH"

FILE_DESKTOP="helix.desktop"
FILE_ICON="helix.png"
BIN_APPDIR="bin/hx"
BIN_ABS="/usr/bin/hx"

# Decompress the AppDIr
unsquashfs -f -d "$NAME" "$FILEPATH"

# Move contents of the AppDir to the appimages directory
mkdir -vp /usr/appimages/
mv -vf "$NAME" /usr/appimages/

# Link the main binary to the system
ln -srf /usr/appimages/"$NAME"/"$BIN_APPDIR" "$BIN_ABS"

# Copy desktop file
cp -va /usr/appimages/"$NAME"/"$FILE_DESKTOP" /usr/share/applications/

# Copy icon file
cp -va /usr/appimages/"$NAME"/"$FILE_ICON" /usr/share/icons/

# Move the config
mkdir -vp "$HOME"/.config/helix
mv -vf /usr/appimages/"$NAME"/_config/* "$HOME"/.config/helix/

# Destroy the compressed AppDir file
rm -v "$FILEPATH"

echo "DONE"
