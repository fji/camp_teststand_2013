camp_teststand_2013
===================

Android test steps for the app defined to be tested in the camp 2013.

Copy this folder into the eclipse project (at the same level as src, res, etc.)

then run the following command replacing the parameters with the values to use:

	$ SERVO_SERVER_ADR="xyz" SERVO_SERVER_PORT="xy" SERVO_SERVER_DEVICE="x" ADB_DEVICE_ARG="xyz" calabash-android run /path/to/binary.apk 

Example: 

	$ SERVO_SERVER_ADR="192.168.1.177" SERVO_SERVER_PORT="80" SERVO_SERVER_DEVICE="2" ADB_DEVICE_ARG="38313550E36500EC" calabash-android run bin/test.apk 