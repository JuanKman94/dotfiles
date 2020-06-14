#!/bin/bash
# 2020-06-13, code extracted from: https://wiki.gentoo.org/wiki/ACPI/ThinkPad-special-buttons

# this is entirely dependent on your hardware (and drivers), edit if needed
BACKLIGHT=/sys/class/backlight/amdgpu_bl0

# Set the static increment value.  Keep in mind that this will
# be done twice.
INC_VAL=20

# Get the Maximum value for use.
#MAX_VAL=$(cat $BACKLIGHT/max_brightness);
read -r MAX_VAL < "$BACKLIGHT/max_brightness"

# Get the current brightness value.
#CURR_VAL=$(cat $BACKLIGHT/brightness);
read -r CURR_VAL < "$BACKLIGHT/brightness"

# Set the new value minus the decrement value.
NEW_VAL=$(($CURR_VAL + $INC_VAL));
echo $NEW_VAL

# Set it to the threshold of the max value.
THRESHOLD_VAL=$(($NEW_VAL<$MAX_VAL?$NEW_VAL:$MAX_VAL))
echo $THRESHOLD_VAL

# Set the new value directly.
echo -n $THRESHOLD_VAL > $BACKLIGHT/brightness

logger "[ACPI] brightnessup $CURR_VAL => $THRESHOLD_VAL"
