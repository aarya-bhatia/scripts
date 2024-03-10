#!/usr/bin/env python3
import i3ipc
from threading import Lock

# Create an instance of the i3 IPC connection
i3 = i3ipc.Connection()

workspace_str = ""
mutex = Lock()


def send_update():
    global workspace_str
    result = []
    workspaces = i3.get_workspaces()
    for ws in workspaces:
        value = f"%{{A:workspace-{ws.name}:}} {ws.name} %{{A}}"
        if ws.focused:
            value = f"%{{+u}}{value}%{{-u}}"
        result.append(value)

    with mutex:
        workspace_str = " ".join(result)
        print(workspace_str, flush=True)


def workspace_event(i3, event):
    send_update()


def mode_event(i3, event):
    global workspace_str
    with mutex:
        if event.change == "default":
            out = workspace_str
        else:
            out = f"{workspace_str}  %{{B#900000}} {event.change} %{{B-}}"

        print(out, flush=True)


# Subscribe to workspace events
i3.on(i3ipc.Event.WORKSPACE_FOCUS, workspace_event)
i3.on(i3ipc.Event.WORKSPACE_INIT, workspace_event)
i3.on(i3ipc.Event.WORKSPACE_EMPTY, workspace_event)
i3.on(i3ipc.Event.WORKSPACE_MOVE, workspace_event)
i3.on(i3ipc.Event.MODE, mode_event)

send_update()
i3.main()
