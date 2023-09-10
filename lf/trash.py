#!/usr/bin/env python3
import os

auto = False
RM = "trash-put"

# Get selected files
fx = os.environ.get('fx', '')

if fx.strip() == "":
    print("No files were selected.")
    exit(1)

filenames = fx.split()
count = 0

# Iterate through the filenames and print them line by line
for filename in filenames:
    if not os.path.exists(filename):
        continue

    ans = 'n'
    if not auto:
        ans = input(f"Delete {filename} [y/n/a/q]: ")
    if ans == 'a':
        auto = True
    if auto or ans == 'y':
        if os.system(f"{RM} \"{filename}\"") == 0:
            count += 1
    if ans == 'q':
        break

print(f"{count}/{len(filenames)} files were deleted")

# TODO: sync files deleted in the cloud...

