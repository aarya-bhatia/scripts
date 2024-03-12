#!/usr/bin/python3
import subprocess
import os
import sys

HISTORY = "/home/aarya/wallpaper.log"
DEFAULT = "/home/aarya/wallpapers/archlinux/sunset.jpg"


def set_wallpaper(filepath):
    print(filepath)
    if subprocess.call(["xwallpaper", "--stretch", filepath]) == 0:
        message = "wallpaper changed: " + filepath
        return os.system(f"notify-send '{message}'")

    print("failed to set wallpaper")
    exit(1)


def update_history(filepath):
    with open(HISTORY, "a") as f:
        f.write(filepath + "\n")


if len(sys.argv) > 1:
    filepath = sys.argv[1]
    set_wallpaper(filepath)
    update_history(filepath)
    exit(0)

filepath = DEFAULT

if os.path.exists(HISTORY):
    with open(HISTORY, "r") as file:
        line = ""
        for line in file:
            pass
        line = line.strip()
        if line:
            filepath = line

set_wallpaper(filepath)
