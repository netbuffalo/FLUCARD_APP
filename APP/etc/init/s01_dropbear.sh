#!/bin/sh

SSHD_USER=root
SSHD_PASSWD=passwd
SSHD_PORT=22
SSHD_DSS_KEY=$APP_HOME/etc/dropbear/dropbear_dss_host_key
SSHD_RSA_KEY=$APP_HOME/etc/dropbear/dropbear_rsa_host_key

if [ ! -f $SSHD_DSS_KEY ]
then
  mkdir $APP_HOME/etc/dropbear
  dropbearkey -t dss -f $SSHD_DSS_KEY
  dropbearkey -t rsa -f $SSHD_RSA_KEY
fi

if [ -f $APP_HOME/bin/dbclient ]
then
  ln -s $APP_HOME/bin/dbclient /usr/bin/ssh
fi

ln -s $APP_HOME/etc/dropbear /etc/dropbear
mount -t devpts /dev/pts
dropbear -A -N $SSHD_USER -C $SSHD_PASSWD -U 0 -G 0 -p $SSHD_PORT
