#!/bin/sh

set -eu

# Get architecture and version
ARCH=$(uname -m)
VERSION="$(sed -n 1p sources.txt)"

# Get Upstream URL and filename
URL_UPS=$(awk "/https/ && /$VERSION/ && /$ARCH/" sources.txt)
FILE_UPS=$(awk "/_helix/ && /$VERSION/ && /$ARCH/" sources.txt)
EXT_UPS=$(awk "/extracted/ && /helix/ && /$VERSION/ && /$ARCH/" sources.txt)

# Get the icon
URL_ICON=$(awk "/https/ && /raw.githubusercontent.com/ && /helix.png/" sources.txt)

# Get the Quick Sharun script
URL_SHARUN=$(awk "/https/ && /raw.githubusercontent.com/ && /quick-sharun.sh/" sources.txt)

# Download the binary from upstream
URL="$URL_UPS"
FNAME="$FILE_UPS"
wget "$URL" -O "$FNAME"

# Download the icon
URL="$URL_ICON"
FNAME="helix.png"
wget "$URL" -O "$FNAME"

# Download the Quick Sharun script
URL="$URL_SHARUN"
FNAME="quick-sharun.sh"
wget "$URL" -O "$FNAME"
chmod +x "$FNAME"

# Create Details directory
DET="AppDir/_details"
mkdir -vp "$DET"

# Write details
echo "$URL_UPS" > "$DET/upstream.txt"
sha256sum "$FILE_UPS" > "$DET/upstream.sha256.txt"

# Extract
mkdir -vp extracted
tar -vxf "$FILE_UPS" -C extracted
mv -v $EXT_UPS extracted/helix-editor

# Create AppDir
mkdir -p AppDir/helix-files

# Copy the "contrib" and the "runtime" directories
cp -va extracted/helix-editor/contrib AppDir/helix-files/
cp -va extracted/helix-editor/runtime AppDir/helix-files/

# Copy the License and the README.md to the details directory
cp -va extracted/helix-editor/LICENSE "$DET"/
cp -va extracted/helix-editor/README.md "$DET"/

# Install basic packages
pacman -Syy --noconfirm \
	base-devel \
	libxtst libxrandr libxkbcommon libxkbcommon-x11 libxi libxcb xorg-server-xvfb \
	systemd-libs

############################################################################################

# STEM="helix-$VERSION-$ARCH-linux"
# TARFILE="$STEM.tar.xz"
# URL_TARFILE="https://github.com/helix-editor/helix/releases/download/$VERSION/$TARFILE"

# URL_ICON="https://raw.githubusercontent.com/helix-editor/helix/refs/heads/master/contrib/helix.png"

# WMCLASS="helix"

# echo "Ensuring Helix ver. $VERSION"
# echo "-------------------------------"

# if ! [ -d "$STEM" ]
# then
#	if ! [ -f "$TARFILE" ]
#	then
#		wget --retry-connrefused --tries=10 "$URL_TARFILE"
#	fi
#	tar -xf "$STEM.tar.xz"
#fi

#if [ ! -f "helix.png" ]
#then
#	wget --retry-connrefused --tries=10 "$URL_ICON"
#fi

#echo "Creating AppDir beforehand"
#echo "--------------------------"

#mkdir -vp AppDir/usr/bin/
#mkdir -vp AppDir/usr/share/applications/
#mkdir -vp AppDir/usr/share/icons/
#mkdir -vp AppDir/usr/lib/helix
#cp -va "$STEM"/* AppDir/usr/lib/helix/

#cp -v helix.desktop AppDir/usr/share/applications/
#cp -v helix.png AppDir/usr/share/icons/

#echo "X-AppImage-Version=$VERSION" >> AppDir/usr/share/applications/helix.desktop
#echo "StartupWMClass=$WMCLASS" >> AppDir/usr/share/applications/helix.desktop

#find AppDir

#echo "
#READY
#"

