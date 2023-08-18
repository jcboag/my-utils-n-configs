# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

export ZDOTDIR=$HOME/.config/zsh

# OTHER VARIABLES
export GOPATH=$HOME/.go
export EDITOR="vim"
export VIM=$HOME/.config/nvim
export XDG_CONFIG_HOME=$HOME/.config 
export HISTFILE=$ZDOTDIR/.zsh_history
export LESSHISTFILE=$XDG_CONFIG_HOME/less/.lesshst
export TODO_DIR=$HOME/Documents/.todo
export LC_ALL=en_US.UTF-8

# export BEMENU_BACKEND=ncurses

export MOZ_ENABLE_WAYLAND=1

# PATH VARIABLE
export PATH=$PATH:$HOME/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/go/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# source "$HOME/.cargo/env"

# LESS 
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
# and so on

# QT5CT

export QT_QPA_PLATFORMTHEME=qt5ct
