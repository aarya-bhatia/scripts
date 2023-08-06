#!/bin/bash
export TODO_DIR="/home/aarya/GoogleDrive/Notes/todos"
LOG_FILE="$HOME/crontab.log"
cd $HOME
echo $(date) >> $LOG_FILE
source $HOME/pyvenv/bin/activate
cd $SCRIPTS_DIR/alert-service
./send_alert.py >> $LOG_FILE 2>&1

