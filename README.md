# Felix' Dot-Files


## Setup

This is a reasonably manual version.

### Basic

``` bash
xcode-select --install
sudo xcodebuild -license
git clone github.com/biggs/dotfiles ~/.dotfiles
```

Link files into place. (TODO: write a setup script for this, possibly with nix.)
- ~/.spacemacs -> spacemacs.el
- ~/.profile -> profile-mac
- ~/.Brewfile -> Brewfile
- ~/.aspell.en.pws -> aspell_personal.txt
- ~/.config/fish/config.fish -> config.fish
- ~/.config/karabiner/karabiner.json -> karabiner.json
- ~/.config/nvim/init.vim -> init.vim



### Nix

``` bash
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

Run some of commands from script to install vim plugins and spacemacs. (TODO: start doing this in nix?)
- `:BundleInstall` and start spacemacs

