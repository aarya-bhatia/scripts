#!/usr/bin/env bash
source /home/aarya/pyvenv/bin/activate
alacritty --class=floating-python -e tmux new-session -s -A python3 "python3"

