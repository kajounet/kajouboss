#!/bin/bash

disk=$1
hash=`echo kajouboss | sha256sum | cut -d " " -f1`
mount="/media/hdd/kajou-upload"
kajouWebsite="/media/hdd/kajou-website/"

function synchronize_kajou()
{
  if [ -f "$mount/$hash" ]; then
    rsync -rv $mount/kajou/ $kajouWebsite

    umount $mount
  fi
}

if grep -qs "$mount" /proc/mounts; then

    synchronize_kajou

else

  if [ -e ${disk} ]; then

    if [ -e ${disk}1 ]; then

      mount  -o ro ${disk}1 $mount

      if [ $? -eq 0 ]; then

        synchronize_kajou

      else

       echo "Something went wrong..."
       exit 1

      fi
    fi
  fi
fi
