#!/bin/bash

CAPACITY_FILE="/sys/class/power_supply/BAT0/capacity"
STATUS_FILE="/sys/class/power_supply/BAT0/status"
CRITICAL_LEVEL=40

CUR_CAPACITY=$(cat ${CAPACITY_FILE})


if [ ${CUR_CAPACITY} -le ${CRITICAL_LEVEL} ]
then
	CUR_STATUS=$(cat ${STATUS_FILE})

	if [ "${CUR_STATUS}" == "Discharging" ]
	then
		export DISPLAY=:0
		export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
		notify-send "Battery Low, ${CUR_CAPACITY}%. Plug-in Charger Immediately"
f
	fi
fi
