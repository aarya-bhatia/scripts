#!/usr/bin/env python3
import os

filename = input().strip()

if filename == "": exit(1)

last = filename.rfind("/")

if last != -1:
    path, filename = filename[:last], filename[last+1:]
    print(path, filename)

    if path != "":
        os.makedirs(path, 0o750, exist_ok=True)

    if filename != "":
        os.close(os.open(path=os.path.join(path, filename),
                 flags=os.O_CREAT | os.O_APPEND, mode=0o640))

else:
    os.close(os.open(path=filename,
             flags=os.O_CREAT | os.O_APPEND, mode=0o640))
