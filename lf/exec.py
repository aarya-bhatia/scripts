import os
import subprocess

# Get selected file
filename = os.environ.get('f', '')
cwd = os.environ.get('OLDPWD', os.curdir)
print(cwd, filename)

if os.path.isfile(filename) and os.access(filename, os.X_OK):
    args = input("args: ").strip().split()
    # os.execv(filename, [filename, *args])
    status = subprocess.call([filename, *args], cwd=cwd)
    if status != 0:
        print("Program failed with status code: ", status)
else:
    print(f"File is not executable: { filename }")
    exit(1)
