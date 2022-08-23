#!/bin/bash
mkdir ~/.config
mkdir /data/config
mkdir /data/sync
ln -s /data/config ~/.config/rclone

if [ ! -f "$HOME/.config/rclone/rclone.conf" ]; then
  echo Please run: rclone config create dropbox dropbox
  echo And place file in /mnt/integrity_store/store/rclone/config/rclone.conf
  sleep 10000
  exit 0
fi

while [ 1 ]
do
  rclone copy /data/sync dropbox:$DROPBOX_PATH --create-empty-src-dirs; \
  rclone copy dropbox:$DROPBOX_PATH /data/sync --create-empty-src-dirs
  sleep 60
done
