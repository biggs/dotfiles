#!/usr/bin/env bash
set -e

# Nice red arrow at beginning
RA="\033[1;31m --> \033[0m"

# This script should setup the dotfiles after pulling to $HOME/.dotfiles
echo -e "\n\n\n       Felix' Dotfiles Setup Script\n\nThis should link dotfiles into place etc."

# Choose the basedir to be the one above this
echo -e "$RA Changing to correct directory"

SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASEDIR="${SCRIPTDIR}/.."







echo -e "$RA spacemacs"

cd "${BASEDIR}" && ln -sf "$BASEDIR/dot.spacemacs" "$HOME/.spacemacs"

EMACSDIR="$HOME/.emacs.d"
if ! cd $EMACSDIR;
    then mkdir -p $EMACSDIR; git clone https://github.com/syl20bnr/spacemacs $EMACSDIR;
    else git pull;
fi






echo -e "$RA Setting up nvim and plugins (TODO: install in background. For now open vim and :BundleInstall)"

# Link Nvim into place
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR" && cd "${BASEDIR}" && ln -s -f "$BASEDIR/dot.vimrc" "$NVIM_CONFIG_DIR/init.vim"


# Download Vundle and use to install plugins (in the background!)
# Tries to change to vundle dir, if doesn't exist makes and clones, otherwise updates
VUNDLE_DIR=$HOME/.vim/bundle/Vundle.vim
if ! cd $VUNDLE_DIR;
    then mkdir -p $VUNDLE_DIR; git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR;
    else git pull;
fi
#vi -u $TANGLE_DIR/install_plugs.vim -c "PluginInstall" -c "qall"




echo -e "$RA zshrc linking"
cd "${BASEDIR}" && ln -s -f "$BASEDIR/dot.zshrc" "$HOME/.zshrc"



echo -e "$RA Brewfile linking"
cd "${BASEDIR}" && ln -s -f "$BASEDIR/dot.Brewfile" "$HOME/.Brewfile"





echo -e "\n       DONE!\n\n\n"
