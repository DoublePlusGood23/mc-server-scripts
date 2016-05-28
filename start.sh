#!/bin/sh

set -e
usermod --uid $UID mc
groupmod --gid $GID mc

chown -R mc:mc /data /start-minecraft
chmod -R g+wX /data /start-minecraft

while lsof -- /start-minecraft; do
  echo -n "."
  sleep 1
done
echo "...switching to user 'mc'"
exec sudo -E -u mc /start-minecraft
