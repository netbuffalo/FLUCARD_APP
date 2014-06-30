#!/bin/sh

SDCARD_HOME=/mnt/sd
APP_HOME=$SDCARD_HOME/APP
FIRE_IMAGE=$SDCARD_HOME/DCIM/123_TREK/TREK9990.JPG
export SDCARD_HOME APP_HOME FIRE_IMAGE

if [ -f $FIRE_IMAGE ]
then
  exit 0
else
  if [ ! -d ${FIRE_IMAGE%/*} ]
  then
    mkdir ${FIRE_IMAGE%/*}
  fi
  cp $SDCARD_HOME/APP/etc/${FIRE_IMAGE##*/} $FIRE_IMAGE || exit 1
fi

#########################################
#        Link external commands         #
#########################################
ln -s $APP_HOME/bin/* /usr/bin/


#########################################
#           Run init scripts            #
#########################################
ls $APP_HOME/etc/init/s*_*.sh | while read script;
do
  chmod 777 $script
  $script > $APP_HOME/logs/${script##*/}.log 2>&1
  sleep 1
done

#########################################
#           Run user scripts            #
#########################################
ls $APP_HOME/action/a*_*.sh | while read action;
do
  chmod 777 $action
  $action > $APP_HOME/logs/${action##*/}.log 2>&1
  sleep 1
done

sync

return 0
