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

# nvm (Homebrew), lazy loaded: the default Node's bin goes on PATH now, and the
# full nvm loads on the first call to `nvm` (or node/npm/npx while no default exists)
export NVM_DIR="$HOME/.nvm"
if [[ -s /opt/homebrew/opt/nvm/nvm.sh ]]; then
  if [[ -r $NVM_DIR/alias/default ]]; then
    _nvm_node=( $NVM_DIR/versions/node/v${$(<$NVM_DIR/alias/default)#v}*(Non[-1]) )
    [[ -n $_nvm_node ]] && path=( $_nvm_node/bin $path )
    unset _nvm_node
  fi
  _nvm_load() {
    unset -f nvm _nvm_load
    source /opt/homebrew/opt/nvm/nvm.sh
  }
  nvm() { _nvm_load; nvm "$@" }
  if (( ! $+commands[node] )); then
    node() { _nvm_load; nvm use default >/dev/null; unset -f node npm npx; node "$@" }
    npm() { _nvm_load; nvm use default >/dev/null; unset -f node npm npx; npm "$@" }
    npx() { _nvm_load; nvm use default >/dev/null; unset -f node npm npx; npx "$@" }
  fi
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto
ENABLE_CORRECTION="true"
plugins=(git z nvm)
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# Drop oh-my-zsh's nocorrect aliases so zsh can correct these commands
unalias cp man mkdir mv sudo su 2>/dev/null

# Powerlevel10k config, if present (run `p10k configure` to create it)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# colorls tab completion
source $(dirname $(gem which colorls))/tab_complete.sh 2>/dev/null

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
