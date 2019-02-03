#####################
# Felix Biggs zshrc #
#####################

# SET PATH IN .profile
source $HOME/.profile


#############################
# Oh-My-Zsh Initializtation #
#############################

if [[ $OSTYPE == darwin* ]]; then
    export ZSH=~/.dotfiles/omz;
elif [[ $OSTYPE == linux* ]]; then
    export ZSH=/media/sf_shared/.dotfiles/omz;
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(fasd git colored-man-pages)
source $ZSH/init.sh



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



# Set myself as default user
DEFAULT_USER=fez

#Display CPU usage stats for commands taking more than 7 seconds
REPORTTIME=7

# Stop using CTRL-S to freeze screen so can use to save in vim instead
stty -ixon






##################
# Emacs and Nvim #
##################

## Vim/Neovim as editor (opens really fast!)
VIM="nvim"

alias vi=$VIM
alias vim=$VIM
alias view="$VIM -R"
alias vdiff="$VIM -d"

export VISUAL=$VIM
export EDITOR=$VIM


# Emacs
alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait --alternate-editor=''"
alias ec="e --create-frame"


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
# MAC SPECIFIC        #
#######################


if [[ $OSTYPE == darwin* ]]; then
    alias ls='exa';
    alias l='exa -l --git';
    alias la='exa -l -a --git';
    alias l2='exa -l --git -T --level 2';

    ## Allow using vlc
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

    alias led='ledger -f ~/Documents/ORG/Finances/money.ledger'
    alias awaketime='pmset -g log | grep -e " Sleep  " -e " Wake  " | tail -n 20'

    # Alias for scholar dl for google scholar articles
    alias schdl="python3 /Users/felix/Projects/scholar_dl/scholar_dl.py"
fi






#######################
# Misc Useful Aliases #
#######################

## launch MIT scheme with a special wrapper for history and competion (rlwrap)
alias sicp="rlwrap -r -c -f \"$HOME\"/.scheme_completion.txt mit-scheme"

## Create alias gitlog, giving much more detailed output for git
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

## History search using grep
alias hgrep='history | grep '

## Download youtube audio with one command
alias ydl="youtube-dl -x"

# Allow iTerm integration for zsh. BUT - check in iTerm first!
[[ $TERM_PROGRAM == "iTerm.app" ]] && test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Python linting
alias mylint='pylint --rcfile=~/.dotfiles/pylint.rc'

# Make `help` command work like bash for builtins
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/path/to/zsh_help_directory
alias help=run-help

# Serve this web page
alias httpshare='echo "WiFi IP Address: " $(ipconfig getifaddr en0) && python3 -m http.server 8000'
