import os

filename = input().strip()

if not os.path.exists(filename):
    if filename[-1] == "/":
        os.mkdir(filename)
    else:
        open(filename, "w").close()
