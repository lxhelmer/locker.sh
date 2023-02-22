# locker.sh
Simple script to make usb connectable for short period.
This script is a simple controller for [USBGuard](https://usbguard.github.io/). and will not work without it.

The code toggles the InsertedDevicePolicy allowing new connections.
After some time, 5s in the gh version the mode is toggled back to reject.
The script excpects the default policy to reject or atleast not "apply-policy".
Some changes to usbguard sudo rules might be relevant.
The script does not take into account white/blacklisting of devices

## BE AWARE
Setting the InsertedDevicePolicy to reject might cause problems if no input device is
connected when usbguard is loading. For me it has not been a problem with laptop and devices connected before
booting have been unaffected by the script and the default policy.

## The script


```shell

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

```
