# Felix' Fish Configuration.


# Import fish-foreign-env to allow PATH from of ~/.profile.
set fish_function_path $fish_function_path \
  ~/.nix-profile/share/fish-foreign-env/functions
fenv source ~/.profile


# Better Greeting.
function fish_greeting
    begin
        echo (date) " @ " (hostname)
        echo
        fortune -a
        echo
    end | lolcat
end


# Install fisher if not installed, and create fishfile to install FASD.
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs \
    -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
if not test -e ~/.config/fish/fishfile
    echo "fishgretel/fasd" | tr ' ' \n > ~/.config/fish/fishfile
end


# Use Powerline as prompt (requires patched fonts).
function fish_prompt
    powerline-go \
    -error $status -shell bare -cwd-mode plain -numeric-exit-codes \
    -modules "venv,ssh,cwd,git,jobs,exit"
end



# Nvim.
set -U EDITOR 'nvim'
alias vi='nvim'
alias view='nvim -R'

# Emacs.
alias ec='/usr/local/Cellar/emacs-mac/emacs-26.1-z-mac-7.4/bin/emacsclient'
alias e='ec --no-wait --quiet --alternate-editor="nvim"'

# Exa.
alias ls='exa';
alias l='exa -l --git';
alias la='exa -l -a --git';
alias l2='exa -l --git -T --level 2';

# Hide copyright.
alias gdb='gdb -q'
alias julia='julia --banner=no'

# Misc.
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias mylint='pylint --rcfile=~/.dotfiles/python/pylint.rc'
alias ca='command --all'



function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end


function nix-up -d "Update nix from ~/.dotfiles/nix/default.nix"
    nix-env -f ~/.dotfiles/nix/default.nix -i --remove-all
end


function ghci-nix -d "Nix shell with haskell and packages."
    set PCKS ""
    for s in $argv
        set PCKS "$s $PCKS"
    end
    nix-shell -p "haskellPackages.ghcWithPackages (ps: with ps; [ $PCKS ])" \
    --command ghci
end
