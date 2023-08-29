#!/bin/sh
status=$(curl --max-time 5 -X HEAD -I https://aaryab.in/ping  | grep HTTP | cut -d ' ' -f2)

if [ $status != "200" ]
then
  notify-send -t 2000 "ALERT: aaryab.in is not available"
fi

echo "test" >> /home/aarya/crontab.log
