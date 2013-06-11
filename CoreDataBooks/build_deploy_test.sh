#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <APP_NAME> <UDID> <IP:Port>" >&2
  exit 1
fi


APP_NAME=$1
UDID=$2
IP_PORT=$3

# build the app bundle using Xcode command line tool
echo "==== Build the app bundle ===="
xcodebuild \
-workspace $APP_NAME'.xcworkspace' \
-scheme $APP_NAME'-cal' \
-configuration Debug \
-arch armv7 \
-sdk iphoneos \
TARGETED_DEVICE_FAMILY=1 \
OBJROOT=$(PWD)/build \
SYMROOT=$(PWD)/build \
clean build

# beam the bundle to the device
echo "==== Deploy to device ===="
./transporter_chief.rb build/Debug-iphoneos/$APP_NAME-cal.app -v


# run the tests
echo "==== Run the tests ===="
DEVICE_ENDPOINT=$IP_PORT BUNDLE_ID=build/$APP_NAME-cal DEVICE_TARGET=$UDID cucumber
