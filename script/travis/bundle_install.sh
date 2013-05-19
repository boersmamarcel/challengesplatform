#!/bin/sh

ARCHITECTURE=`uname -m`
FILE_NAME="$BUNDLE_ARCHIVE-$ARCHITECTURE.tgz"

cd ~
wget -O "remote_$FILE_NAME" "http://$SECRET_BUNDLE_IP:8080/$FILE_NAME" && tar -xf "remote_$FILE_NAME"
wget -O "remote_$FILE_NAME.sha2" "http://$SECRET_BUNDLE_IP:8080/$FILE_NAME.sha2"

exit 0
