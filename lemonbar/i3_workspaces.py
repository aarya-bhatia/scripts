#!/usr/bin/env python3
import i3ipc

# idle = 0
# active = 1
# focus = 2
#
# workspaces = {}
# prev_focus = None
#
# for i in range(1, 11):
#     workspaces[str(i)] = active
#
# Create an instance of the i3 IPC connection
i3 = i3ipc.Connection()


def send_update():
    result = []
    workspaces = i3.get_workspaces()
    for ws in workspaces:
        value = f" {ws.name} "
        if ws.focused:
            value = f"%{{+u}}{value}%{{-u}}"
        result.append(value)
    print(" ".join(result), flush=True)


def on_workspace_focus(self, event):
    # global prev_focus
    # global workspaces
    # if prev_focus:
    #     workspaces[prev_focus] = active
    #
    # prev_focus = event.current.name
    # workspaces[prev_focus] = focus
    send_update()


# Subscribe to workspace events
i3.on(i3ipc.Event.WORKSPACE_FOCUS, on_workspace_focus)
i3.on(i3ipc.Event.WORKSPACE_INIT, on_workspace_focus)
i3.on(i3ipc.Event.WORKSPACE_EMPTY, on_workspace_focus)
i3.on(i3ipc.Event.WORKSPACE_MOVE, on_workspace_focus)

send_update()
i3.main()
