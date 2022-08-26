#!/bin/bash
mkdir ~/.config
mkdir /data/config
mkdir /data/sync/shared-input
mkdir /data/sync/shared-output
ln -s /data/config ~/.config/rclone

if [ ! -f "$HOME/.config/rclone/rclone.conf" ]; then
  echo Please run: rclone config create dropbox dropbox
  echo And place file in /mnt/integrity_store/store/rclone/config/rclone.conf
  sleep 10000
fi

#rclone config create dropbox dropbox
while [ 1 ]
do
  time rclone copy /data/sync/shared-output dropbox:$DROPBOX_PATH_OUTPUT --create-empty-src-dirs
  touch /data/sync/shared-input/.rclone_lock
  time rclone copy dropbox:$DROPBOX_PATH_INPUT /data/sync/shared-input --create-empty-src-dirs
  rm -rf /data/sync/shared-input/.rclone_lock
  sleep 30
done
