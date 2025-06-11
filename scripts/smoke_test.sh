#!/usr/bin/env bash
set -e
adb shell am start -n com.example.ergomotion/.MainActivity
sleep 5
adb shell dumpsys window windows | grep -i ergomotion
