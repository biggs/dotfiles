# Felix' Dot-Files


## Setup
This is a more manual version of the script at (https://macos-strap.herokuapp.com/).
Run these commands:
`xcode-select --install`

`sudo xcodebuild -license`

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

`brew update`

`sudo softwareupdate --install --all`

`GITHUB_DOTFILES="https://github.com/biggs/dotfiles"`

`git clone $Q "$DOTFILES_URL" ~/.dotfiles`

`bash ~/.dotfiles/script/setup`

`cd && brew bundle --global`



Then start iterm with the newly installed zsh and run:
`nvim` and `:BundleInstall`
and start spacemacs



After this script runs `script/setup` you should open emacs to download the packages and run
`:BundleInstall` in nvim.

TODO: Update - use nix for install...
