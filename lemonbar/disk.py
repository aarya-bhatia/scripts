#!/usr/bin/env python3
import psutil
import time

label = "\uf07b"
label2 = ""

while True:
    stat = psutil.disk_usage("/home")
    home_usage = round(100*stat.used/stat.total, 2)

    stat = psutil.disk_usage("/")
    root_usage = round(100*stat.used/stat.total, 2)

    print(f"/ {root_usage}% {label} {home_usage}%", flush=True)

    time.sleep(10)
