#!/usr/bin/env python

import os
import i3
import sys
import pickle

PATH = "~/.cache/carbs/i3_workspace_mapping"


def show_help():
    print(sys.argv[0] + " [save|load]")
    sys.exit(1)


def save():
    pickle.dump(i3.get_workspaces(), open(PATH, "wb"))


def load():
    try:
        workspace_mapping = pickle.load(open(PATH, "rb"))
    except Exception:
        print("Can't find existing mappings...")
        sys.exit(1)

    for workspace in workspace_mapping:
        i3.msg(
            'command',
            f"workspace {workspace['name']}",
        )
        i3.msg(
            'command',
            f"move workspace to output workspace['output']",
        )
    for workspace in filter(lambda w: w['visible'], workspace_mapping):
        i3.msg(
            'command',
            f"workspace workspace['name']",
        )

cmd = {
    'save': save(),
    'load': load(),
}

def plug():
    if len(sys.argv) < 2:
        show_help()
    command = sys.argv[1]
    _cmd = cmd.get(command, show_help)
    _cmd()

if __name__ == '__main__':
    plug()
