#!/usr/bin/env bash

set -ex

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TANGLE_DIR="${BASEDIR}/tangled"

cd "${BASEDIR}"
stow --dir=$TANGLE_DIR --target=$HOME vim
ln -sf $TANGLE_DIR/vim/.vimrc $TANGLE_DIR/nvim/.config/nvim/init.vim 
stow --dir=$TANGLE_DIR --target=$HOME nvim
stow --dir=$TANGLE_DIR --target=$HOME zsh

# Download Vundle and use to install plugins (in the background!)
VUNDLE_DIR=$HOME/.vim/bundle/Vundle.vim
if ! cd $VUNDLE_DIR;
    then mkdir -p $VUNDLE_DIR; git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR;
    else git pull;
fi
vi -u $TANGLE_DIR/install_plugs.vim -c "PluginInstall" -c "qall"


# Spacemacs
cd $BASEDIR && ln -s spacemacs.el ~/.spacemacs
