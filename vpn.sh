#!/bin/sh
if [ ! -f $HOME/.passwd ]; then
	read -p "Enter NETID password > " PASSWD
else
	PASSWD=$(cat $HOME/.passwd)
fi

VPNGROUP="OpenConnect1 (Split)"
USERNAME="aaryab2@illinois.edu"
HOST="vpn.illinois.edu"

read -p "auth [push/sms/otp]: " OTP

echo $VPNGROUP:$USERNAME:$PASSWD:$OTP | sed "s/:/\n/g" | sudo openconnect -q $HOST
