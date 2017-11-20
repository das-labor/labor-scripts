#!/bin/bash

STATE=$(ping -q -w 1 -c 1 das-labor.org > /dev/null && echo ok || echo error)

if [  $STATE == "error" ]
then
    sh ../usb-display/display.sh '** Netzwerk nicht' 'erreichbar **'
fi

