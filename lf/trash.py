import sys
import os

# Get the value of the $fx environment variable
fx = os.environ.get('fx', '')

# Split the filenames by newline characters
filenames = fx.split()

# Iterate through the filenames and print them line by line
for filename in filenames:
    ans = input(f"delete {filename} [y/n]?")
    if ans == 'y':
        os.remove(filename)

# for filename in sys.stdin:
#     print(filename)
#
#     if "GoogleDrive/" in filename:
#         start = filename.index("GoogleDrive")
#         start += len("GoogleDrive/")
#         path = filename[start:]
#         if len(path) > 0:
#             print(path)
#
#     if "OneDrive/" in filename:
#         start = filename.index("OneDrive")
#         start += len("OneDrive/")
#         path = filename[start:]
#         if len(path) > 0:
#             print(path)
#
