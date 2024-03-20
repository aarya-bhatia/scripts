#!/bin/sh
ufw enable
ufw default deny
ufw allow from 192.168.0.0/24
ufw limit ssh
ufw status

systemctl enable ufw
systemctl start ufw
