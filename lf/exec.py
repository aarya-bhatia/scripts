#!/usr/bin/env python3
import os
import sys
import subprocess

# Get selected file
filename = os.environ.get('f', '')
cwd = os.environ.get('OLDPWD', os.curdir)
print(cwd, filename)

args = ""

if os.path.isfile(filename) and os.access(filename, os.X_OK):
    if len(sys.argv) > 1 and sys.argv[1] == "args":
        args = input("Args: ").strip().split()
        status = subprocess.call([filename, *args], cwd=cwd)
    else:
        status = subprocess.call([filename], cwd=cwd)

    if status != 0:
        print("Program failed with status code: ", status)
else:
    print(f"File is not executable: { filename }")
    exit(1)

