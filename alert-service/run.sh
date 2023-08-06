#!/bin/bash
export TODO_DIR="/home/aarya/GoogleDrive/Notes/todos"
cd /home/aarya
echo $(date) >> crontab.log
source ./pyvenv/bin/activate
cd ./dotfiles/scripts/alert-service
./send_alert.py >> ~/crontab.log 2>&1

