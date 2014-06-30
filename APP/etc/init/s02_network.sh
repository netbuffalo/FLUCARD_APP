#!/bin/sh

if [ ! -f $APP_HOME/etc/network/wifi.conf ]
then
  exit 0
else
  . $APP_HOME/etc/network/wifi.conf
fi

if [ "$ONBOOT" != "yes" ]
then
  exit 0
fi

# load driver
w1

# set this so that can connect to router at channel 13
iwpriv $DEVICE regioncode 0x41

uaputl bss_stop

ifconfig $DEVICE down

wpa_supplicant -i $DEVICE -B -c $APP_HOME/etc/network/$WPACONF

iwpriv $DEVICE htcapinfo 0x4020000

if [ "$BOOTPROTO" = "static" ]
then
  ifconfig $DEVICE $IPADDR netmask $NETMASK up
  route add default gw $GATEWAY
  echo "nameserver $DNS" > /etc/resolv.conf
else
  udhcpc -i $DEVICE -s /etc/dhcp.script
fi


