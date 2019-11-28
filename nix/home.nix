{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # List of packages to install.
  home.packages = (import ./core.nix) ++
    [
      # MacOS only.
      pkgs.darwin.trash
      pkgs.wifi-password
    ];

  # Link dotfiles into place.
  home.file = {
    # Re-tangle doom config on rebuild (breaks goto doom-private-dir).
    ".config/doom" = {
      source = ../emacs;
      recursive = true;
      onChange = ''~/.emacs.d/bin/doom refresh'';
    };

    ".config/fish/config.fish".source = ../fish/config.fish;
    ".gitconfig".source = ../git/gitconfig;
    ".config/nvim/init.vim".source = ../vim/init.vim;

    # MacOS Only
    ".profile".source = ../mac/profile-mac;
    ".Brewfile".source = ../mac/Brewfile;
  };
}
