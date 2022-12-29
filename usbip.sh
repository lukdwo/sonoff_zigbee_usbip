#!/bin/bash

FILE=`ls -la  /dev/ttyUSB0 | cut -d " " -f 10`
echo $FILE
DATA=`date +%Y-%m-%d_%H:%M:%S`
if [[ ! "$FILE" = "/dev/ttyUSB0" ]]; then
modprobe vhci-hcd
ssh user@192.168.100.101 -p 2222 'usbip unbind -b 3-1' 2>/dev/null
ssh user@192.168.100.101 -p 2222 'usbip bind -b 3-1'
usbip attach -r 192.168.100.101 -b 3-1
echo "Podlaczono usbip: "$DATA >> usbip.log
sleep 5
docker start zigbee2mqtt
fi
exit 0
