#!/bin/sh
if [ ! -f $HOME/.passwd ]; then
	echo "Password file not found"
	printf "Enter password > "
	read PASSWD
else
	PASSWD=$(cat $HOME/.passwd)
fi

# VPNGROUP="1_SplitTunnel_Default"
VPNGROUP="OpenConnect1 (Split)"
USERNAME="aaryab2@illinois.edu"
HOST="vpn.illinois.edu"

read -p "Enter Duo Passcode: " OTP

echo $VPNGROUP:$USERNAME:$PASSWD:$OTP | sed "s/:/\n/g" | sudo openconnect -q $HOST
