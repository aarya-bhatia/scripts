#!/usr/bin/env python3
import platform
import datetime


def get_system_uptime():
    if platform.system() == "Linux":
        with open("/proc/uptime", "r") as uptime_file:
            uptime_seconds = float(uptime_file.readline().split()[0])
            return uptime_seconds

    print("Platform not supported.")
    exit(1)


def format_uptime(uptime_seconds):
    uptime = datetime.timedelta(seconds=uptime_seconds)

    if uptime < datetime.timedelta(hours=1):
        return f"{round(uptime.seconds / 60, 2)} minutes"
    elif uptime < datetime.timedelta(days=1):
        return f"{round(uptime.seconds / 3600, 2)} hours"
    else:
        hours = uptime.seconds / 3600
        days = uptime.days + (hours/24)
        return f"{round(days,2)} days"


uptime_seconds = get_system_uptime()
formatted_uptime = format_uptime(uptime_seconds)
print(formatted_uptime)
