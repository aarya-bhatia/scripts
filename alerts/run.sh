#!/bin/sh
export TODO_DIR="/home/aarya/GoogleDrive/Notes/todos"
LOG_FILE="/home/aarya/crontab.log"
cd /home/aarya
echo $(date) >> $LOG_FILE
source /home/aarya/pyvenv/bin/activate
cd /home/aarya/scripts/alert-service
./send_alert.py >> $LOG_FILE 2>&1

