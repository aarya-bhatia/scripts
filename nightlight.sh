#!/bin/bash
if [ $# -eq 0 ]
then
  echo "Help"
  printf "Turn on nighlight: %s on\n" $0
  printf "Turn off nighlight: %s off\n" $0
  exit 1
fi

if [ $1 == "on" ]; then
  redshift -P -O 3700
  echo "Nighlight on..."
elif [ $1 == "off" ]; then
  redshift -x
  echo "Nightlight off..."
elif [ $1 == "auto" ]; then
	redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq -r '"\(.location.lat):\(.location.lng)"') &
else
  echo "unknown option"
fi
