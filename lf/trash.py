import sys

for filename in sys.stdin:
    print(filename)

    if "GoogleDrive/" in filename:
        start = filename.index("GoogleDrive")
        start += len("GoogleDrive/")
        path = filename[start:]
        if len(path) > 0:
            print(path)

    if "OneDrive/" in filename:
        start = filename.index("OneDrive")
        start += len("OneDrive/")
        path = filename[start:]
        if len(path) > 0:
            print(path)

