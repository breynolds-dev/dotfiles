# dotfiles

Everything needed to set up a new machine (macOS first).

> **Status: work in progress.** `install.sh` and `zsh/.zshrc` are written but untested. See [HANDOFF.md](HANDOFF.md).

## Layout

| Path | Purpose |
| --- | --- |
| `install.sh` | Entry point: Homebrew, clone repo, `brew bundle`, oh-my-zsh, symlinks, then both scripts below |
| `Brewfile` | Homebrew packages (chruby, gh, git, libffi, libyaml, nvm, pipx, pnpm, pyenv, ruby-install, skillshare; tap versenilvis/iris for IRIS autocomplete; casks claude, codex, copilot-cli, herdr-app (Herdr installs herdr core on first launch), font-fira-code-nerd-font, font-victor-mono-nerd-font). Scripts expect `brew bundle` to have run first. |
| `scripts/install-node.sh` | Installs Node 22 with nvm (Homebrew) and makes it the default |
| `scripts/install-colorls.sh` | Ruby 3.4 via chruby, colorls 1.5.0. Verified end to end on Apple Silicon. |
| `scripts/install-skills.sh` | Initialises it against this repo, installs skills, syncs |
| `skills/` | skillshare **source**: the AI agent skills, synced to every agent |
| `agents/` | skillshare agents source (empty) |
| `zsh/.zshrc` | Sanitized zsh config (IRIS init, nvm, chruby, oh-my-zsh, p10k if present, colorls completion), symlinked to `~/.zshrc`. An existing `~/.zshrc` is backed up. Machine-specific config goes in untracked `~/.zshrc.local`. |

## Agent skills (skillshare)

[skillshare](https://github.com/runkids/skillshare) keeps one source of skills
(`skills/` in this repo) and links them into each agent's skills directory.

| Target | Path |
| --- | --- |
| Claude Code | `~/.claude/skills` |
| Codex | `~/.agents/skills` |
| Copilot CLI | reads `~/.agents/skills`, so no separate target |

Set up (or re-run, it is idempotent):

```zsh
./scripts/install-skills.sh
```

Day to day:

```zsh
skillshare install <user/repo> --all   # add skills (also add the repo to SKILL_REPOS in the script)
skillshare sync                        # link skills into all targets
skillshare update                      # pull updates for installed skills
skillshare doctor                      # diagnose problems
skillshare audit                       # security-scan skills
```

Installed skills:

- [`mattpocock/skills`](https://github.com/mattpocock/skills): 39 skills

Audit notes: two HIGH findings are expected false positives.
`setup-matt-pocock-skills` edits `CLAUDE.md`/`AGENTS.md` by design, and
`migrate-to-shoehorn` has an origin metadata mismatch.

The skillshare config is `~/.config/skillshare/config.yaml` and stores absolute
paths, so `install-skills.sh` runs `init --source <repo>/skills` on each new
machine.

## Planned

1. Publish as a public repo so this works:

   ```zsh
   curl -fsSL https://raw.githubusercontent.com/breynolds-dev/dotfiles/main/install.sh | bash
   ```

Never commit secrets.

## Notes

- IRIS is built from a third-party tap and has no bottle, so Homebrew needs
  current Xcode Command Line Tools to build it. `install.sh` runs
  `brew trust --formula versenilvis/iris/iris` first.
