#!/bin/bash

FILE="/dev/ttyUSB0"
DATA=`date +%Y-%m-%d_%H:%M:%S`
if [[ ! -e "$FILE" ]]; then
#modprobe vhci-hcd
ssh root@192.168.100.254 -p 2222 'usbipd -D && sleep 2 && usbip unbind -b 1-2' 2>/dev/null
ssh root@192.168.100.254 -p 2222 'usbip bind -b 1-2'
sudo /usr/sbin/usbip attach -r 192.168.100.254 -b 1-2
echo "Podlaczono usbip: "$DATA
sleep 5
fi
sudo chown luk:luk /home/docker/zigbee2mqtt/ttyUSB0
sudo -u luk docker start zigbee2mqtt
sudo -u luk docker exec -it homeassistant sh -c "cp -R /config/.ssh/ /root/ && chmod 700 /root/.ssh && chmod 600 /root/.ssh/*"
echo "Ostatnie wywolanie":
date
exit 0

