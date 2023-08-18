# Requires: zinit


# COMPLETIONS
zstyle ':completion:*:manuals'   separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*'     menu yes select
# zstyle ':completion:*' 			 list-colors "${(@s.:.)LS_COLORS}"
. "$HOME/.local/share/lscolors.sh"

# OPTIONS
setopt AUTO_CD
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt PROMPTSUBST

# HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
export HISTSIZE=5000
export HISTFILESIZE=1000
export SAVEHIST=5000

# KEY
export KEYTIMEOUT=1
# bindkey -v # handled by zsh-vim-mode plugin

# COMMANDS
autoload -U promptinit;promptinit
autoload -Uz compinit && compinit

alias open="zathura_detach"
function zathura_detach () {
    zathura $1 &!
}

function precmd() {
    if [ "$LAST_DIR" != "$PWD" ]; then
        print -s "##dir## $PWD"
        LAST_DIR=$PWD
    fi
}


# FONTS
source ~/.local/share/fonts/*.sh

# ALIASES
source "$ZDOTDIR/.zaliases"

# PLUGINS
source "$ZDOTDIR/.zplugins"
