#!/usr/bin/env bash
set -u

herdr="${HERDR_BIN_PATH:-herdr}"
state="${HERDR_PLUGIN_STATE_DIR:-/tmp/herdr-pane-autorename}"
mkdir -p "$state"

cache_get() { cat "$state/$1" 2>/dev/null || true; }
cache_set() { printf '%s' "$2" >"$state/$1"; }

while true; do
  mapfile -t panes < <("$herdr" pane list 2>/dev/null | jq -r '.result.panes[].pane_id' 2>/dev/null)

  for pane in "${panes[@]}"; do
    [ -n "$pane" ] || continue
    name=$("$herdr" pane process-info --pane "$pane" 2>/dev/null |
      jq -r '.result.process_info.foreground_processes[].name // empty' 2>/dev/null) || continue
    [ -n "$name" ] || continue
    if [ "$name" != "$(cache_get "$pane")" ]; then
      "$herdr" pane rename "$pane" "$name" >/dev/null 2>&1 && cache_set "$pane" "$name"
    fi
  done
  sleep 1
done
