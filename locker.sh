#!/bin/sh

STATE=$(usbguard get-parameter InsertedDevicePolicy)

if [ $STATE = "apply-policy" ];
then
	usbguard set-parameter InsertedDevicePolicy reject
	echo "USB no more connectable"
else
	usbguard set-parameter InsertedDevicePolicy apply-policy
	echo "USB connectable"
	sleep 5s
	sh ./locker.sh
fi

