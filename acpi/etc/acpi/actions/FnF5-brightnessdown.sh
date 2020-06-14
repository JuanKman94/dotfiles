#!/bin/bash
# 2020-06-13, code extracted from: https://wiki.gentoo.org/wiki/ACPI/ThinkPad-special-buttons

# this is entirely dependent on your hardware (and drivers), edit if needed
BACKLIGHT=/sys/class/backlight/amdgpu_bl0

# Set the static decrement value.  Keep in mind that this will be done twice.
DEC_VAL=20

# Set the Minimum we will accept.
MIN_VAL=0

# Get the current brightness value.
#CURR_VAL=$(cat $BACKLIGHT/brightness);
read -r CURR_VAL < "$BACKLIGHT/brightness"

# Set the new value minus the decrement value.
NEW_VAL=$(($CURR_VAL - $DEC_VAL));
echo $NEW_VAL

# Set it to the threshold of the min value.
THRESHOLD_VAL=$(($NEW_VAL>$MIN_VAL?$NEW_VAL:$MIN_VAL))
echo $THRESHOLD_VAL

# Set the new value directly.
echo -n $THRESHOLD_VAL > $BACKLIGHT/brightness

logger "[ACPI] brightnessdown $CURR_VAL => $THRESHOLD_VAL"
