#!/bin/sh
if [ ! -f $HOME/passwd ]; then
	echo "Password file not found"
	printf "Enter password > "
	read PASSWD
else
	PASSWD=$(cat $HOME/passwd)
fi

VPNGROUP="1_SplitTunnel_Default"
USERNAME="aaryab2@illinois.edu"
HOST="vpn.illinois.edu"

printf "%s\n%s\n%s\n" $VPNGROUP $USERNAME $PASSWD | sudo openconnect $HOST


