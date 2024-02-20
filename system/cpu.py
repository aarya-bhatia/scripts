#!/usr/bin/env python3
import psutil
import sys

value=0
while True:
    sys.stdout.write(f"CPU: {value}%\n")
    sys.stdout.flush()
    value = psutil.cpu_percent(interval=5)
