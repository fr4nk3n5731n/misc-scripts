#!/bin/bash

VERSION=$(curl -S "https://dl.google.com/widevine-cdm/current.txt" 2>/dev/null || echo "0")
OLD_VERSION="$((cat latest 2>/dev/null) || echo '0')"
WIDEVINE_DIRECTORY="$HOME/.kodi/cdm/"

if [ ! -d $WIDEVINE_DIRECTORY ]; then
	mkdir -p $WIDEVINE_DIRECTORY
fi

if [ "$VERSION" > "$OLD_VERSION" ]; then
	DOWNLOAD_URL="https://dl.google.com/widevine-cdm/$VERSION-linux-x64.zip"
	wget -P "/tmp" "$DOWNLOAD_URL" \
	&& unzip -o "/tmp/$VERSION-linux-x64.zip" -x "LICENSE.txt" "manifest.json" -d "$WIDEVINE_DIRECTORY" \
	&& rm -f "/tmp/$VERSION-linux-x64.zip" \
	&& echo "$VERSION" > "$WIDEVINE_DIRECTORY/latest"
	exit 0
else
	exit 0
fi