#!/bin/bash

# CURRENTDIR

set -e

SCRIPT_NAME=$(basename "$0")

USAGE="
$SCRIPT_NAME

Description:
Extracts the bundled runtime directory to a different location

Usage:
\$ $SCRIPT_NAME [TARGET_PATH]

NOTE:
→ This script DOES NOT copy the runtime dir as a single item. 'TARGET_PATH' is the path to the directory where the contents of the runtime dir will be copied to
→ Make sure the parent directory of 'TARGET_PATH' exists first
"

if ! [ $# -eq 1 ]
then
	echo "$USAGE"
	exit 0
fi

DESTINATION=$(realpath "$1")

mkdir -v "$DESTINATION"

cp -va "$CURRENTDIR/bin/runtime"/* "$DESTINATION"

echo "
ALL DONE!
"
