#!/bin/sh
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
  # redshift -x
  echo "Nightlight off..."
else
  echo "unknown option"
fi
