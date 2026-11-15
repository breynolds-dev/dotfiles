#!/usr/bin/env bash
# Installs colorls (Ruby via chruby) on macOS with zsh.
# Safe to re-run.
set -euo pipefail

RUBY_VERSION="3.4.12"
COLORLS_VERSION="1.5.0"

command -v brew >/dev/null || { echo "Homebrew is required: https://brew.sh"; exit 1; }
# chruby, ruby-install and the Nerd Font come from the Brewfile (brew bundle)
brew list chruby ruby-install >/dev/null || { echo "Run: brew bundle"; exit 1; }
BREW_PREFIX="$(brew --prefix)"

echo "==> Installing Ruby $RUBY_VERSION"
if [ ! -d "$HOME/.rubies/ruby-$RUBY_VERSION" ]; then
  ruby-install ruby "$RUBY_VERSION"
fi

echo "==> Installing colorls $COLORLS_VERSION"
# shellcheck disable=SC1091
# chruby.sh is not safe under `set -u`
set +u
source "$BREW_PREFIX/opt/chruby/share/chruby/chruby.sh"
chruby "ruby-$RUBY_VERSION"
set -u
gem install colorls -v "$COLORLS_VERSION"

# Shell config (chruby, tab completion) lives in zsh/.zshrc

echo
echo "Done. Next steps:"
echo "  1. Set your terminal font to 'FiraCode Nerd Font'."
echo "  2. Open a new terminal, then run: colorls --version && colorls -l --git-status"
