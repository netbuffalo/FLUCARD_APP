#!/bin/sh

if [ -f $FIRE_IMAGE ]
then
  echo "removing $FIRE_IMAGE"
  rm -rf $FIRE_IMAGE
else
  echo "Not found: $FIRE_IMAGE"
fi
