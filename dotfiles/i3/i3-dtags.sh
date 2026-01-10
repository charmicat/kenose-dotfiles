#!/usr/bin/env bash

I3MSG=$(command -v i3-msg) || exit 1
JQ=$(command -v jq) || exit 2
DMENU=$(command -v dmenu) || exit 3

TARGET=$($I3MSG -t get_workspaces | $JQ -r '.[].name' | sort -u | $DMENU "$@")
[ -n "$TARGET" ] && $I3MSG workspace "$TARGET"

