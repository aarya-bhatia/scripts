#!/bin/sh

if xrandr | grep -q "HDMI-1 connected"; then
  # HDMI-1 is connected
  echo "HDMI-1 is connected..."
  # Mirror main display with monitor
  xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal
else
  # HDMI-1 is not connected, display a message
  echo "HDMI-1 is not connected..."
fi

