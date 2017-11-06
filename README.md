# Felix' Dot-Files


Go to: [https://macos-strap.herokuapp.com/] and run the generated script.
(also could store in Dropbox, although it contains an auth token and so is insecure.)

This is basically a script which idempotently sets up command-line tools and homebrew
and downloads your dotfiles github directory, then brews the brewfile and runs `script/setup`.
See [https://github.com/MikeMcQuaid/strap#features] for more details.



TODO:
- create `script/setup`
- migrate oh-my-zsh to something lighter
