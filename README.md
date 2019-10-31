# Felix' Dot-Files


## Setup

```sh
xcode-select --install
sudo xcodebuild -license
git clone github.com/biggs/dotfiles ~/.dotfiles
```

Link files into place (would be better if this was stateless.)
```sh
mkdir -p ~/.config/ ~/.config/fish ~/.config/nvim
ln -s /Users/felix/.dotfiles/emacs/ ~/.config/doom
ln -s /Users/felix/.dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s /Users/felix/.dotfiles/git/gitconfig ~/.gitconfig
# ln -s /Users/felix/.dotfiles/mac/karabiner.json ~/.config/karabiner/karabiner.json
ln -s /Users/felix/.dotfiles/mac/Brewfile ~/.Brewfile
ln -s /Users/felix/.dotfiles/mac/profile-mac ~/.profile
ln -s /Users/felix/.dotfiles/vim ~/.config/nvim/init.vim
```


## Nix

```sh
sh <(curl https://nixos.org/nix/install)   # restart after to get into path.
nix-env --file ~/.dotfiles/default.nix --install --remove-all
```
NOTE: check that sourcing nix hasn't been added twice to `.profile`.


### Homebrew

``` bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
sudo softwareupdate --install --all
cd && brew bundle --global
```

Run more commands from script to install vim plugins and doom.
- `:BundleInstall` and start spacemacs

