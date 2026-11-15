#!/usr/bin/env bash
# Bootstrap a new machine (macOS).
#   curl -fsSL https://raw.githubusercontent.com/breynolds-dev/dotfiles/main/install.sh | bash
# Safe to re-run.
set -euo pipefail

REPO_URL="https://github.com/breynolds-dev/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Development/dotfiles}"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Only macOS is supported for now." >&2
  exit 1
fi

echo "==> Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done

echo "==> Dotfiles repo ($DOTFILES_DIR)"
if [ -d "$DOTFILES_DIR/.git" ]; then
  git -C "$DOTFILES_DIR" pull --ff-only
else
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

echo "==> brew bundle"
# IRIS comes from a third-party tap; Homebrew requires an explicit trust for it
brew tap versenilvis/iris
brew trust --formula versenilvis/iris/iris
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Symlinks"
link() { # link <source> <dest>
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    mv "$2" "$2.backup.$(date +%Y%m%d%H%M%S)"
  fi
  ln -sfn "$1" "$2"
}
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "==> Agent skills"
"$DOTFILES_DIR/scripts/install-skills.sh"

echo "==> Node (nvm)"
"$DOTFILES_DIR/scripts/install-node.sh"

echo "==> colorls"
"$DOTFILES_DIR/scripts/install-colorls.sh"

echo "Done. Open a new terminal."
