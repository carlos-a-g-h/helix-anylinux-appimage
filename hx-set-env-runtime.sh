#!/bin/bash

set -e

SCRIPT_NAME=$(basename "$0")

USAGE="
$SCRIPT_NAME

$PATH

Description:
Writes an ENV file with a path to a custom runtime directory

Usage:
\$ $SCRIPT_NAME [TARGET_PATH]

NOTE:
→ 
"

if ! [ $# -eq 1 ]
then
	echo "$USAGE"
	exit 0
fi

TARGET_PATH=$(realpath "$1")

ENV_FILEPATH="$URUNTIME".env

echo "HELIX_RUNTIME = \"$TARGET_PATH\"" > "$ENV_FILEPATH"

ls "$ENV_FILEPATH"

cat "$ENV_FILEPATH"

echo "
ALL DONE!
"
