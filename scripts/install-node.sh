#!/usr/bin/env bash
# Installs Node via nvm (Homebrew) and makes it the default. Safe to re-run.
set -euo pipefail

NODE_VERSION="22"
NVM_SH="$(brew --prefix nvm 2>/dev/null)/nvm.sh"

[ -s "$NVM_SH" ] || { echo "nvm missing. Run: brew bundle"; exit 1; }

export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"

# nvm.sh is not safe under `set -u`
set +u
# shellcheck disable=SC1090
source "$NVM_SH"
nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"
set -u

node --version
