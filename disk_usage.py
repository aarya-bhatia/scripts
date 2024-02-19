#!/usr/bin/env python3
import shutil

stat = shutil.disk_usage("/home")
home_usage = round(100*stat.used/stat.total,2)

stat = shutil.disk_usage("/")
root_usage = round(100*stat.used/stat.total,2)

print(f"/:{root_usage}% /home:{home_usage}%")

