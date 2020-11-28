#!/bin/bash

CAPACITY_FILE="/sys/class/power_supply/BAT0/capacity"
STATUS_FILE="/sys/class/power_supply/BAT0/status"
CAPACITY_LOWER_BOUND=40
CAPACITY_UPPER_BOUND=90

CUR_CAPACITY=$(cat ${CAPACITY_FILE})
CUR_STATUS=$(cat ${STATUS_FILE})


notify(){
	export DISPLAY=:0
	export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${UID}/bus
	notify-send "$1"
}

if [ ${CUR_CAPACITY} -le ${CAPACITY_LOWER_BOUND} ]
then
	if [ "${CUR_STATUS}" == "Discharging" ]
	then
		notify "Battery Low, ${CUR_CAPACITY}%. Plug-in Charger Immediately"
	fi
elif [ ${CUR_CAPACITY} -ge ${CAPACITY_UPPER_BOUND} ]
then
	if [ "${CUR_STATUS}" == "Charging" ]
	then
                notify "Battery almost full, ${CUR_CAPACITY}%. Unplug charger"
	fi
fi


