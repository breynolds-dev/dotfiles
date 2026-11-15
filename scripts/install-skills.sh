#!/usr/bin/env bash
# Sets up skillshare for claude/codex (and Copilot via codex's path) and installs skills.
# Requires skillshare from the Brewfile.
set -euo pipefail

SKILL_REPOS=(
  "mattpocock/skills"
)
# Copilot CLI already reads ~/.agents/skills, which the codex target writes
TARGETS="claude,codex"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

command -v skillshare >/dev/null 2>&1 || { echo "skillshare missing. Run: brew bundle"; exit 1; }

if [ ! -f "$HOME/.config/skillshare/config.yaml" ]; then
  skillshare init --source "$REPO_DIR/skills" --no-copy --no-git --skill -t "$TARGETS"
fi

for repo in "${SKILL_REPOS[@]}"; do
  skillshare install "$repo" --all
done

skillshare sync
