#!/bin/bash
#
# Get monitor blank information to block inputs if the screen is blank.

MONITOR_FILE="/home/dietpi/.mupibox/Sonos-Kids-Controller-master/server/config/monitor.json"

while true
do

        if [ ! -f ${MONITOR_FILE} ]; then
                sudo echo -n "{}" ${MONITOR_FILE}
                chown dietpi:dietpi ${MONITOR_FILE}
                /usr/bin/cat <<< $(/usr/bin/jq -n --arg v "On" '.monitor = $v' ${MONITOR_FILE}) >  ${MONITOR_FILE}
        elif [ -n ${MONITOR_FILE} ]; then
                /usr/bin/cat <<< $(/usr/bin/jq -n --arg v "On" '.monitor = $v' ${MONITOR_FILE}) >  ${MONITOR_FILE}
        else
                MONITOR=$(DISPLAY=:0 xset q | grep "Monitor" | awk '{print $3}')
                /usr/bin/cat <<< $(/usr/bin/jq --arg v "${MONITOR}" '.monitor = $v' ${MONITOR_FILE}) >  ${MONITOR_FILE}
        fi

	sleep 1
done