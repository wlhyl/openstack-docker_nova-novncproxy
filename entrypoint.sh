#!/bin/bash

if [ -z "$VNCSERVER_PROXYCLIENT_ADDRESS" ];then
  echo "error: VNCSERVER_PROXYCLIENT_ADDRESS not set"
  exit 1
fi

if [ -z "$MY_IP" ];then
  echo "error: MY_IP not set. my_ip use management interface IP address."
  exit 1
fi

CRUDINI='/usr/bin/crudini'

if [ ! -f /etc/nova/.complete ];then
    cp -rp /nova/* /etc/nova

    chown nova:nova /var/log/nova/

    $CRUDINI --set /etc/nova/nova.conf DEFAULT vncserver_listen 0.0.0.0

    $CRUDINI --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address $VNCSERVER_PROXYCLIENT_ADDRESS
    
    $CRUDINI --set /etc/nova/nova.conf DEFAULT my_ip $MY_IP

    touch /etc/nova/.complete
fi

/usr/bin/supervisord -n