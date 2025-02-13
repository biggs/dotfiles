#!/bin/bash

# Battery monitoring script
BATTERY_PATH="/sys/class/power_supply/BAT0"
LAST_NOTIFIED_LEVEL=100

while true; do
    # Get current battery level
    BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
    CHARGING_STATUS=$(cat "$BATTERY_PATH/status")

    # Only notify if discharging
    if [ "$CHARGING_STATUS" = "Discharging" ]; then
        if [ $BATTERY_LEVEL -le 10 ] && [ $LAST_NOTIFIED_LEVEL -gt 10 ]; then
            notify-send -u critical "Battery Critical" "Battery level is ${BATTERY_LEVEL}%!"
            LAST_NOTIFIED_LEVEL=10
        elif [ $BATTERY_LEVEL -le 25 ] && [ $LAST_NOTIFIED_LEVEL -gt 25 ]; then
            notify-send -u normal "Battery Low" "Battery level is ${BATTERY_LEVEL}%"
            LAST_NOTIFIED_LEVEL=25
        elif [ $BATTERY_LEVEL -le 50 ] && [ $LAST_NOTIFIED_LEVEL -gt 50 ]; then
            notify-send -u low "Battery Notice" "Battery level is ${BATTERY_LEVEL}%"
            LAST_NOTIFIED_LEVEL=50
        fi
    else
        # Reset notification level when charging
        LAST_NOTIFIED_LEVEL=100
    fi

    # Check every 60 seconds
    sleep 60
done
