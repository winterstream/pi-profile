#!/usr/bin/env bash

PROFILE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_FILE="$PROFILE_ROOT/profile.json"
PROFILE_LOCK="$PROFILE_ROOT/profile.lock.json"
PROFILE_SETTINGS="$PROFILE_ROOT/.pi/settings.json"
PI_DIR="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"
PROFILE_STATE="$PI_DIR/pi-profile-state.json"

profile_entries_json() {
  jq -c --slurpfile lock "$PROFILE_LOCK" '
    [
      .packages[] as $package
      | ($lock[0].packages[$package.id]) as $locked
      | ($package.resources // {}) as $resources
      | if ($resources | length) == 0 then
          $locked.source
        else
          {source: $locked.source}
          + (if ($resources | has("extensions")) then {extensions: $resources.extensions} else {} end)
          + (if ($resources | has("skills")) then {skills: $resources.skills} else {} end)
          + (if ($resources | has("prompts")) then {prompts: $resources.prompts} else {} end)
          + (if ($resources | has("themes")) then {themes: $resources.themes} else {} end)
        end
    ]
  ' "$PROFILE_FILE"
}

profile_sources_json() {
  profile_entries_json | jq -c '[.[] | if type == "string" then . else .source end]'
}

profile_sources() {
  profile_sources_json | jq -r '.[]'
}
