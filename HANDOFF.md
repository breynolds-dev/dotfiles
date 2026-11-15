# Session Handoff

## Goal
A `dotfiles` repo holding everything needed to set up a new machine (macOS first): Homebrew, brew packages/casks, Ruby + colorls, shell config. Ultimately installable with:

```zsh
curl -fsSL https://raw.githubusercontent.com/breynolds-dev/dotfiles/main/install.sh | bash
```

## Done so far
- Repo initialised at `~/Development/dotfiles` (branch `main`, no remote, no commits yet).
- `scripts/install-colorls.sh`: copied from the previous session. Installs chruby + ruby-install, the FiraCode Nerd Font, Ruby 2.6.10, colorls 1.4.6, and adds chruby and tab-completion lines to `~/.zshrc` (idempotent). Syntax-checked only, never run end to end.
- `zsh/` directory created (empty).

## Facts about the source machine
- macOS, Apple Silicon, zsh + oh-my-zsh (theme robbyrussell, plugins: git z nvm), p10k sourced if present.
- colorls 1.4.6 on Ruby 2.6.10 via chruby; no custom colorls config, no `ls` alias.
- Brew leaves: act apache-arrow automake bison chruby gh git libffi libyaml pipx pnpm pyenv python@3.10 ruby-install tree watchman
- Brew casks (fonts): font-fira-code-nerd-font, font-hack-nerd-font, font-victor-mono-nerd-font
- Terminal in use: Ghostty (no config file found).

## Next steps
1. Write `Brewfile` (leaves above + font casks; review what's actually wanted).
2. Write `install.sh` entry point: install Homebrew if missing (macOS), `brew bundle`, then run `scripts/install-colorls.sh`. For the curl one-liner to work, it must clone the repo (or fetch the scripts) first.
3. Add a sanitized `zsh/.zshrc` (omit machine-specific entries such as fig-export, console-ninja) and symlink it from `install.sh`.
4. Add a `README.md` with usage.
5. Test on a clean machine/VM; verify the Ruby 2.6.10 build (OpenSSL 1.1) works on Apple Silicon, and consider moving to a newer Ruby.
6. Commit, create a public GitHub repo (`gh repo create dotfiles --public --source . --push`), and confirm the curl one-liner.

## Notes
- Public repo/gist is needed for the unauthenticated raw curl URL. Don't commit secrets.
- The original script also still exists at `~/Development/pandemic-legacy-web/install-colorls.sh` (untracked there; safe to delete).
