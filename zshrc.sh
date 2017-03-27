############# PATH AND ADD EXTRA STUFF TO PATH #############

## Set the path to the mac default, then add /bin as personal choice
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
PATH=$PATH:~/bin

## Append python 3.4 path to $PATH
#export PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/3.4/bin"

## MacPorts append to $PATH as needed
export PATH="${PATH}:/opt/local/bin:/opt/local/sbin"

## append tex to path:
export PATH="${PATH}:/usr/texbin"
#
# added by Anaconda3 4.2.0 installer
export PATH="/Users/fez/anaconda3/bin:$PATH"


############## ZSH CUSTOMISATION ################

# Path to your oh-my-zsh installation. (runs zsh customisations)
# MOST OF THE INTERESTING STUFF IS IN /.oh-my-zsh/lib

export ZSH=/Users/fez/.oh-my-zsh

ZSH_THEME="mytheme"
ENABLE_CORRECTION="true"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# PLUGINS TO LOAD
plugins=(git z zsh-syntax-highlighting)

# Add a custom manfile for z
alias 'manz'='man /Users/fez/.oh-my-zsh/custom/plugins/z.1'

source $ZSH/oh-my-zsh.sh

# Set myself as default user
DEFAULT_USER=fez

#Display CPU usage stats for commands taking more than 7 seconds
REPORTTIME=7

# Stop using CTRL-S to freeze screen so can use to save in vim instead
stty -ixon



############ EDITORS ###################
## UP TO DATE EMACS AND VI
alias emacs="emacs-25.1"
alias vi='nvim'

## Emacs as client edit in background shortcut. (if not started, start emacs with empty alt-editor string)
alias e="/usr/local/Cellar/emacs/25.1/bin/emacsclient --no-wait --alternate-editor=''"
alias ec="e --create-frame"

## Neovim as editor (opens really fast!)
export VISUAL="nvim"
export EDITOR="nvim"

## set nvim as man page reader! (N.B. automatically uses 'neoman' plugin. Personally add
## 'less' keybindings and Q for quit - q is remapped after start by neoman to :close)
alias man="man -P \"nvim -R -c 'set ft=man' -c 'runtime! macros/less.vim' -c 'noremap Q :q!<CR>' -\" "

# Allow returning to Vim by pressing Ctrl+Z (actually just runs fg)
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0  ]]; then
        BUFFER=" fg"  # include space so not in history
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z



############# MODIFY EXISTING COMMANDS + CREATE SPECIAL #############

## launch MIT scheme with a special wrapper for history and competion (rlwrap)
alias sicp="rlwrap -r -c -f \"$HOME\"/.scheme_completion.txt mit-scheme"

## Colorize ls
## (-F slash after directory; -G color; -h human size units with -l)
alias ls='ls -FGh'

## Create alias gitlog, giving much more detailed output for git
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

## get internet speed
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

## Allow using vlc
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

## History search using grep
alias hgrep='history | grep '

## Download youtube music with one command
alias ydl="youtube-dl -x"
