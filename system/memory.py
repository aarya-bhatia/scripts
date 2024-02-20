#!/usr/bin/env python3
import psutil
import time
import numpy
import sys

usage=0
while True:
    sys.stdout.write(f"MEM: {usage}%\n")
    sys.stdout.flush()
    res = psutil.virtual_memory()
    used = res.total - (res.free + res.buffers + res.cached)
    usage = int(100 * used / res.total)
    time.sleep(3)
