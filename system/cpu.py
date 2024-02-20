#!/usr/bin/env python3
import psutil
import sys
import numpy as np

average=0
while True:
    sys.stdout.write(f"CPU: {average}%\n")
    sys.stdout.flush()
    values = []
    for i in range(5):
        values.append(psutil.cpu_percent(interval=1))
    average = int(np.mean(values))
