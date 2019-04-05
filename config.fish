# Install fisher if not installed, and create fishfile.
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs \
    -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
if not test -e ~/.config/fish/fishfile
    echo "fishgretel/fasd edc/bass" | tr ' ' \n > ~/.config/fish/fishfile
end


function fish_prompt
    powerline-go \
    -error $status -shell bare -cwd-mode plain -numeric-exit-codes \
    -modules "venv,ssh,cwd,git,jobs,exit"
end


set -U EDITOR 'nvim'


# ALIASES

# Vi
alias vi='nvim'
alias view='nvim -R'

# Don't show copyright
alias gdb='gdb -q'

## Create alias gitlog, giving much more detailed output for git
alias gitlog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Useful alias for inspecting commands:
alias ca='command --all'


# Mac or Linux specific
switch (uname)
    case Linux
        echo "Hi Felix"

    case Darwin
        # Use bass plugin so treated like a bash script.
        bass source $HOME/.profile

        # ls with exa
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

        # Virtualbox aliases
        alias linux-start='vboxmanage startvm UbuntuServer --type headless'
        alias linux-ssh='ssh -p 2222 felix@localhost'
        alias linux-shutdown='vboxmanage controlvm UbuntuServer acpipowerbutton'
        alias linux-list='vboxmanage list'

        # Python linting
        alias mylint='pylint --rcfile=~/.dotfiles/pylint.rc'

        # Emacs client. If not started, use nvim.
        alias emacsclient='/usr/local/Cellar/emacs-mac/emacs-26.1-z-mac-7.4/bin/emacsclient'
        alias e='emacsclient --no-wait --quiet --alternate-editor="nvim"'
end

# Run Linux server virtual machine.
function linux -d "Start and login to Ubuntu server"
    if linux-list runningvms | grep "UbuntuServer" >> /dev/null
        echo "Server Running"
        echo "Logging in..."
        ssh -p 2222 felix@localhost
    else
        echo "Starting Server..."
        vboxmanage startvm UbuntuServer --type headless
        sleep 10
        echo "Logging in..."
        ssh -p 2222 felix@localhost
    end
end



# Nix stuff

function nix-up -d "Update nix from ~/.dotfiles/default.nix"
    nix-env -f ~/.dotfiles/default.nix -i --remove-all
end

function ghc-shell -d "Nix shell with haskell and packages."
    set PCKS ""
    for s in $argv
        set PCKS "''$s'' $PCKS"
    end
    nix-shell -p "haskellPackages.ghcWithPackages (ps: with ps; [ $PCKS ])"
end
