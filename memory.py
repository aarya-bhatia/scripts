#!/usr/bin/env python3
import psutil
import time
import sys

label = ""
usage = 0
while True:
    sys.stdout.write(f"{label} {usage}%\n")
    sys.stdout.flush()
    res = psutil.virtual_memory()
    used = res.total - (res.free + res.buffers + res.cached)
    usage = int(100 * used / res.total)
    time.sleep(5)
