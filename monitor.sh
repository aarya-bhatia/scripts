#!/bin/sh
status=$(curl -X HEAD -I https://aaryab.in  | grep HTTP | cut -d ' ' -f2)

if [ $status != "200" ]
then
  notify-send -t 2000 "ALERT: aaryab.in is not available"
fi
