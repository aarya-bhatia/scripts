#!/usr/bin/env python3
import os

auto = False
RM = "rm -rf"
HOME=os.environ.get("HOME","/home")

if os.environ.get('PWD','').startswith(HOME):
    RM = "trash-put"

print("Using remove command: " + RM)

# Get selected files
fx = os.environ.get('fx', '')

if fx.strip() == "":
    print("No files were selected.")
    exit(1)

filenames = fx.split('\n')
count = 0

# Iterate through the filenames and print them line by line
for i in range(len(filenames)):
    filename = filenames[i]

    if not os.path.exists(filename):
        continue

    ans = 'n'
    if not auto:
        ans = input(f"Delete ({i}/{len(filenames)}) \"{filename}\" [y/n/a/q]: ")
    if ans == 'a':
        auto = True
    if auto or ans == 'y':
        if os.system(f"{RM} \"{filename}\"") == 0:
            count += 1
    if ans == 'q':
        break

print(f"{count}/{len(filenames)} files were deleted")

# TODO: sync files deleted in the cloud...

