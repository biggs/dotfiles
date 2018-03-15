#####################
# Felix Biggs zshrc #
#####################


########
# PATH #
########

## Set the path to the mac default, then add /bin as personal choice
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:/usr/local/miniconda3/bin"
export PATH="$PATH:/Library/TeX/texbin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # Prepend gnu uitilities to replace
export PATH="$PATH:/usr/bin/python" # for aws




#############################
# Oh-My-Zsh Initializtation #
#############################

# Oh-My-Zsh is a set of Zsh plugins and customisations. It is quite heavyweight,
# so I would like to move to something else at some point.

# Most of its interesting functionality is in the oh-my-zsh/lib folder.

# This sets the paths to oh-my-zsh, to a custom directory which is automatically loaded by
# it, chooses a few settings and plugins and then actually loads it.


# *Plugins*
# - [[https://github.com/robbyrussell/oh-my-zsh][git]] :: shows info about an occupied git directory
# - [[][fasd]] :: a clever script that stores recently used directories that can then be skipped to
# - [[https://github.com/zsh-users/zsh-syntax-highlighting][zsh-syntax-highlighting]] :: installed in custom; fish like shell syntax highlighting


export ZSH=/Users/felix/Projects/dotfiles/oh-my-zsh
export ZSH_CUSTOM=/Users/felix/Projects/dotfiles/zsh_custom

ZSH_THEME="mytheme"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"  # red dots
plugins=(git zsh-syntax-highlighting colored-man-pages fasd)

source $ZSH/oh-my-zsh.sh








#############################
# Keybinding Customisations #
#############################

#  Keybindings
# You can view the ZSH command bindings with ~bindkey -L~, but there are many. These
# are some I find particularly useful.

# | ^A | beginning-of-line                          |
# | ^L | clear-screen                               |
# | ^E | end-of-line                                |

# | ^K | kill-line                                  |
# | ^U | kill-whole-line                            |
# | ^W | backward-kill-word                         |
# | ^N | down-line-or-history                       |
# | ^O | accept-line-and-down-history # not in bash |
# | ^P | up-line-or-history                         |
# | ^R | history-incremental-search-backward        |
# | ^Y | self-insert  # paste back killed text!!    |


# Now more advanced, not in bash:
# | ^[>  | end-of-buffer-or-history                                                 |
# | ^[n  | history-search-forward  # searches for the first word only               |
# | ^[p  | history-search-backward                                                  |

# | ^[q  | push-line  # save the current command - after pressing enter, reappears! |
# | ^Q   | push-line  # same as above                                               |

# | ^X ^V | vi-cmd-mode  # literally just go briefly to vi 'normal' mode |
# | ^X ^E | edit-command-line  # open cmd line in $EDITOR                |
# | ^_    | undo  # actually also equivalent to <C-/>                    |

# Also: ~push-line-or-edit~ - bind to something as really useful

# Note these are the emacs commands. One of the final commands listed, ^X ^V, which
# temporarily skips into vi command mode for moving around and editing, is so useful I
# give it an extra keybinding to <ESC><ESC>.

bindkey -e  # emacs keybindings
bindkey "^[^[" vi-cmd-mode  # temporarily switch to vi-cmd-mode (equivalent to ^X^V)








#############################
# Misc Other Customisations #
#############################


# Set myself as default user
DEFAULT_USER=felix

#Display CPU usage stats for commands taking more than 7 seconds
REPORTTIME=7

# Stop using CTRL-S to freeze screen so can use to save in vim instead
stty -ixon

## Neovim as editor (opens really fast!)
export VISUAL="nvim"
export EDITOR="nvim"




# Set myself as default user
DEFAULT_USER=fez

#Display CPU usage stats for commands taking more than 7 seconds
REPORTTIME=7

# Stop using CTRL-S to freeze screen so can use to save in vim instead
stty -ixon






##################
# Emacs and Nvim #
##################


## Neovim as editor (opens really fast!)
export VISUAL="nvim"
export EDITOR="nvim"

alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait --alternate-editor=''"
alias ec="e --create-frame"

alias vi='nvim'
alias view='nvim -R'
alias vdiff='nvim -d'

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









#######################
# Misc Useful Aliases #
#######################


## launch MIT scheme with a special wrapper for history and competion (rlwrap)
alias sicp="rlwrap -r -c -f \"$HOME\"/.scheme_completion.txt mit-scheme"

## Colorize ls
## (-F slash after directory; -G color; -h human size units with -l)
alias ls='exa'
alias l='exa -l --git'
alias la='exa -l -a --git'
alias l2='exa -l --git -T --level 2'

## Create alias gitlog, giving much more detailed output for git
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

## get internet speed
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

## Allow using vlc
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

## History search using grep
alias hgrep='history | grep '

## Download youtube audio with one command
alias ydl="youtube-dl -x"

alias led='ledger -f ~/Documents/Finances/money.ledger'

alias awaketime='pmset -g log | grep -e " Sleep  " -e " Wake  " | tail -n 20'
