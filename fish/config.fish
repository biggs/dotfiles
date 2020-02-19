# Felix' Fish Configuration.


# Import fish-foreign-env to allow PATH from of ~/.profile.
set fish_function_path $fish_function_path \
  ~/.nix-profile/share/fish-foreign-env/functions
fenv source ~/.profile

# Add Emacs Directly to Path in MacOS
switch (uname)
    case Darwin
        export PATH="/usr/local/Cellar/emacs-mac/emacs-26.1-z-mac-7.4/bin/:$PATH"
end

# Better Greeting.
function fish_greeting
    begin
        echo (date) " @ " (hostname)
        echo
        fortune -a
        echo
    end | lolcat
end


# Use Powerline as prompt (requires patched fonts).
function fish_prompt
    powerline-go \
    -error $status -shell bare -cwd-mode plain -numeric-exit-codes \
    -modules "venv,ssh,cwd,git,jobs,exit"
end



# Fasd (no plugin version, since I only use 'z').
function fasd_cd -d "fasd builtin cd"
  if test (count $argv) -le 1
    command fasd "$argv"
  else
    set -l ret (command fasd -e 'printf %s' $argv)
    test -z "$ret"; and return
    test -d "$ret"; and cd "$ret"; or printf "%s\n" $ret
  end
end

function __fasd_print_completion
  set cmd (commandline -po)
  test (count $cmd) -ge 2; and fasd $argv $cmd[2..-1] -l
end

alias z='fasd_cd -d'
complete -c z -a "(__fasd_print_completion -d)" -f -A



# Nvim.
set -U EDITOR 'nvim'
alias vi='nvim'
alias view='nvim -R'

# Emacs.
alias e='emacsclient --no-wait --quiet --alternate-editor="nvim"'

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



function zshsearch -d "Search through zsh history"
    command awk --field-separator=';' '/'$argv'/{$1=""; print}' ~/.zsh_history
end


function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end


function ghci-nix -d "Nix shell with haskell and packages."
    set PCKS ""
    for s in $argv
        set PCKS "$s $PCKS"
    end
    nix-shell -p "haskellPackages.ghcWithPackages (ps: with ps; [ $PCKS ])" \
    --command ghci
end
