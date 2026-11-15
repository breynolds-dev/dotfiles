# Managed in ~/Development/dotfiles/zsh/.zshrc (symlinked to ~/.zshrc).
# Machine-specific additions go in ~/.zshrc.local (not tracked).

# IRIS autocomplete
command -v iris >/dev/null && eval "$(iris init zsh)"

# chruby
if [[ -f /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]]; then
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto
ENABLE_CORRECTION="true"
plugins=(git z nvm)
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# Powerlevel10k config, if present (run `p10k configure` to create it)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# colorls tab completion
source $(dirname $(gem which colorls))/tab_complete.sh 2>/dev/null

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
