# Felix' Dot-Files


Go to: [https://macos-strap.herokuapp.com/] and run the generated script.
(also could store in Dropbox, although it contains an auth token and so is insecure.)

This is basically a script which idempotently sets up command-line tools and homebrew
and downloads your dotfiles github directory, then brews the brewfile and runs `script/setup`.
In that order. See [https://github.com/MikeMcQuaid/strap#features] for more details.


After this script runs `script/setup` you should open emacs to download the packages and run
`:BundleInstall` in nvim.



TODO:
- migrate oh-my-zsh to something lighter
- add a global .gitignore
