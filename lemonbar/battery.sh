#!/bin/sh
BATTACPI=$(acpi --battery | grep -v "unavailable")
BATPERC=$(echo $BATTACPI | cut -d, -f2 | tr -d '[:space:]')
BATPERC=$(echo $BATPERC | tr -d %)

Get() {
	# if [[ $BATTACPI == *"100%"* ]]
	# then
		# echo -e -n "\uf00c $BATPERC"
	if [[ $BATTACPI == *"Discharging"* ]]
	then
		echo "$BATPERC-"
		# BATPERC=${BATPERC::-1}
		# if [ $BATPERC -le "10" ]
		# then
		# 	echo -e -n "\uf244"
		# elif [ $BATPERC -le "25" ]
		# then
		# 	echo -e -n "\uf243"
		# elif [ $BATPERC -le "50" ]
		# then
		# 	echo -e -n "\uf242"
		# elif [ $BATPERC -le "75" ]
		# then
		# 	echo -e -n "\uf241"
		# elif [ $BATPERC -le "100" ]
		# then
		# 	echo -e -n "\uf240"
		# fi
		# echo -e " $BATPERC%"
	elif [[ $BATTACPI == *"Charging"* ]] # && $BATTACPI != *"100%"* ]]
	then
		# echo -e "\uf0e7 $BATPERC"
		echo "$BATPERC+"
	else
		echo "$BATPERC"
	fi
	# elif [[ $BATTACPI == *"Unknown"* ]]
	# then
	# 	echo -e "$BATPERC"
	# fi
}

echo b: $(Get)
