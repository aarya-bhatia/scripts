#!/bin/sh
session_name="personal"
tmux has-session -t $session_name

if [ $? != 0 ]
then
  tmux new-session -s $session_name -n bash -d
  tmux send-keys -t $session_name 'cd $HOME' C-m

  tmux new-window -n notes -t $session_name
  tmux send-keys -t $session_name:2 'cd ~/GoogleDrive/Notes' C-m

  tmux new-window -n monitor -t $session_name
  tmux send-keys -t $session_name:3 'htop' C-m
fi

tmux attach -t $session_name

