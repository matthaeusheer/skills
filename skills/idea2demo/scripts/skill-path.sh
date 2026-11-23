#!/usr/bin/env bash
# Print the SKILL.md path of an installed mattpocock-skills skill.
# Usage: skill-path.sh <skill-name>
set -euo pipefail

name=${1:?usage: skill-path.sh <skill-name>}
installed="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/plugins/installed_plugins.json"

root=$(jq -r '.plugins | to_entries[] | select(.key | startswith("mattpocock-skills@")) | .value[0].installPath' "$installed" | head -n1)
[ -n "$root" ] || { echo "mattpocock-skills is not installed" >&2; exit 1; }

path=$(find "$root/skills" -path "*/$name/SKILL.md" -print -quit)
[ -n "$path" ] || { echo "skill not found in mattpocock-skills: $name" >&2; exit 1; }
echo "$path"
