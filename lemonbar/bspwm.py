#!/usr/bin/env python3
import subprocess

# black = #000
# white = #fff
# grey = #aaa
# darkgrey = #555
# red = #f00
# green = #0f0

desktops = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]


def GetFocused():
    proc = subprocess.run("bspc query -D --names -d focused".split(),
                          capture_output=True,
                          text=True)
    return proc.stdout.strip()


def GetActiveSet():
    proc = subprocess.run("bspc query -D --names -d .occupied".split(),
                          capture_output=True,
                          text=True)
    res = set()
    for line in proc.stdout.splitlines():
        res.add(line.strip())

    return res


def GetDesktops():
    focused = GetFocused()
    active = GetActiveSet()

    res = []
    for desktop in desktops:
        format = desktop
        if focused == desktop:
            format = "[" + desktop + "]"
        elif desktop not in active:
            format = "%{F#555555}" + desktop + "%{F-}"

        format = f"%{{A1:bspc desktop -f {desktop}:}}{format}%{{A}}"
        res.append(format)

    print(" ".join(res), flush=True)


GetDesktops()

with subprocess.Popen(["bspc", "subscribe", "desktop_focus", "node_transfer"],
                      stdout=subprocess.PIPE) as p:
    while True:
        line = p.stdout.readline()
        if not line:
            break

        GetDesktops()
