# This file goes in ~/.bash_profile (the tilde is your home directory)

# ==ENVIROMENT-VARIABLES========================================================
  export EDITOR='atom'                                                          # Set to your text editor
  export PATH="/usr/local/bin:$HOME/bin:$HOME/code/dotfiles/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"          # Look for executables in homebrew first
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# ==COLOR-ALIASES===============================================================
          RED="\[\033[0;31m\]"
       YELLOW="\[\033[1;33m\]"
        GREEN="\[\033[0;32m\]"
         BLUE="\[\033[1;34m\]"
       PURPLE="\[\033[0;35m\]"
    LIGHT_RED="\[\033[1;31m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
        WHITE="\[\033[1;37m\]"
   LIGHT_GRAY="\[\033[0;37m\]"
   COLOR_NONE="\[\e[0m\]"

# ==ALIASES=====================================================================
  export GREP_OPTIONS='--color=auto'
  test -e ~/.dircolors && \
    eval `gdircolors -b ~/.dircolors`

  # =SYSTEM-ALIASES===========================================================
  alias reload="source ~/.bash_profile"       # Used to reload the bash shell after making changes
  alias bashprofile="atom ~/.bash_profile"    # Open's the .bash_profile in atom editor quickly

  function md { mkdir $1; cd $1; }            # Creates a Directory then CDs right into the new directory

  alias grep="grep --color=always"
  alias egrep="egrep --color=always"

  alias cp='cp -iv'                           # Preferred 'cp' implementation
  alias mv='mv -iv'                           # Preferred 'mv' implementation
  alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
  alias ls="ls --color=always"                # LS with colors
  alias ll='ls -FGlAhp --color=always'        # Preferred 'ls' implementation
  alias ..='cd ../'                           # Go back 1 directory level
  alias ...='cd ../../'                       # Go back 2 directory levels
  alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
  alias ~="cd ~"                              # ~:            Go Home
  alias c='clear'                             # c:            Clear terminal display
  alias which='type -all'                     # which:        Find executables

  # =EQUIPMENT-SHARE==========================================================
  alias eslogin="cd ~/equipmentShare/es-login"
  alias estrack="cd ~/equipmentShare/es-mono/app/es-track"
  alias esadmin="cd ~/equipmentShare/es-mono/app/es-admin"
  alias esapi="cd ~/equipmentShare/es-mono/lib/es-api-client"
  alias esreact="cd ~/equipmentShare/es-mono/lib/es-react-components"
  alias kernel="cd ~/equipmentShare/es-kernel/v1/es"

  # =GITHUB-ALIASES===========================================================
  alias gs="git status"
  alias ga="git add"
  alias gb="git branch"
  alias gp="git push"
  alias gcm="git commit -m"
  alias gco="git checkout"
  alias grb="git rebase -i"

  source ~/git-completion.bash

  __git_complete gb _git_branch
  __git_complete gp _git_push
  __git_complete gpl _git_pull
  __git_complete gco _git_checkout
  __git_complete gm _git_merge

# ==PATH-ALIASES================================================================
cd() {
  builtin cd "$@" && ll
}

# ==PROMPT======================================================================
function parse_git_branch {
  branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
  if [ "HEAD" = "$branch" ]; then
    echo "(no branch)"
  else
    echo "$branch"
  fi
}

function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      echo ""
  else
      echo "${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function prompt_segment {
  if [[ ! -z "$1" ]]; then
    echo "\[\033[${2:-37};49m\]${1}\[\033[0m\]"
  fi
}

function build_mah_prompt {
  # time
  ps1="\n$(prompt_segment " [\[\e[4;97m\]\@\[\e[m\]]")"
  countstr=" [00:00 AM] "

  # git branch
  git_branch=`parse_git_branch`
  if [[ ! -z "$git_branch" ]]; then countstr+=" [$git_branch]- "; fi

  line="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /-}"`"
  ps1="${ps1} \[\e[90m\]${line:${#countstr}}\[\e[m\]"

  if [[ ! -z "$git_branch" ]]; then ps1="${ps1} $(prompt_segment " [$git_branch] " 91)"; fi

  # cwd with coloured current directory
  fullpath=`pwd`
  path="$(dirname "$fullpath")"
  dir="$(basename "$fullpath")"
  ps1="${ps1}\n $(prompt_segment "\[\e[90m\]$path/\[\e[m\]")$(prompt_segment "\[\e[1;4;97m\]$dir\[\e[m\]" 34)"

  # next line
  ps1="${ps1}\n \[\e[1;91m\]➔\[\e[m\]  "

  # output
  PS1="$ps1"

  # PS1="$PS1\e[1m\e[32m${dts}${line:${#dts}}"
}

PROMPT_COMMAND='build_mah_prompt'

eval "$(thefuck --alias)"
