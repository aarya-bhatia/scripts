#!/usr/bin/env python3
import psutil
import time

while True:
    stat = psutil.disk_usage("/home")
    home_usage = round(100*stat.used/stat.total, 2)

    stat = psutil.disk_usage("/")
    root_usage = round(100*stat.used/stat.total, 2)

    print(f"/ {root_usage}%  {home_usage}%", flush=True)

    time.sleep(5)