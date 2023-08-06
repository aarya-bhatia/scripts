#!/usr/bin/python3
import re
from datetime import datetime
import os
import shutil
import subprocess

home_path = str(os.environ.get("HOME"))
fzf_path = str(shutil.which("fzf"))
nvim_path = str(shutil.which("nvim"))

filemarks = os.path.join(home_path, ".local/share/aarya/filemarks")

if not os.path.exists(filemarks):
    os.system(f"touch {filemarks}")
    exit(0)


def timestamp_and_filename_mapper(input):
    match = re.match(r"\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\] (.*)", input)
    if match:
        timestamp_str = match.group(1)
        filename = match.group(2)

        # Convert timestamp string to datetime object
        timestamp = datetime.strptime(timestamp_str, "%Y-%m-%d %H:%M:%S")

        return [timestamp, filename]


with open(filemarks, "r") as f:
    lines = f.readlines()
    lines = list(map(timestamp_and_filename_mapper, lines))
    lines.sort(key=lambda x: x[0])  # Sort the array based on timestamps
    filenames = set(map(lambda x: x[1], lines))  # Get the unique filenames
    filenames = list(filter(lambda filename: os.path.exists(filename), filenames)) # Filter out valid files

    # Launch fzf in multiline mode and pipe stdin and stdout
    fzf_proc = subprocess.Popen([fzf_path, '-m'], stdin=subprocess.PIPE,
                                stdout=subprocess.PIPE, text=True)

    # Send filename to fzf stdin
    for filename in filenames:
        fzf_proc.stdin.write(filename + "\n")

    fzf_proc.stdin.close()

    # Read selected filenames from fzf
    selected = []
    lines = fzf_proc.stdout.readlines()

    # Get absolute filepaths
    for line in lines:
        selected.append(os.path.abspath(line.strip()))

    print(selected)

    # Launch neovim and populate args with selected files
    os.execv(nvim_path, [nvim_path, *selected])
