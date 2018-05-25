source ~/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle trapd00r/zsh-syntax-highlighting-filetypes
antigen bundle peterhurford/git-it-on.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle rupa/z

# -------------------------------------------------------------------
# some alias settings, just for fun
# -------------------------------------------------------------------
#alias 'today=calendar -A 0 -f ~/calendar/calendar.mark | sort'
alias lh='ls -a | egrep "^\."'
alias reload="source ~/.zshrc"

# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

# Load the theme.
DEFAULT_USER=”whoami”

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=...
POWERLEVEL9K_SHORTEN_STRATEGY=”truncate_from_right”

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user time dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)

POWERLEVEL9K_MODE='nerdfont-complete'

antigen theme bhilburn/powerlevel9k powerlevel9k

# Tell Antigen that you're done.
antigen apply
