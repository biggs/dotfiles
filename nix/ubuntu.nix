{ config, pkgs, ... }:

with import <nixpkgs> {};

let
  # Personal Info
  name = "Felix Biggs";
  email = "felixbig@gmail.com";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # List of packages to install.
  home.packages = (import ./core.nix) ++
    [
      # Emacs (ubuntu goodies)
      pkgs.emacs

      # More ubuntu specific
      pkgs.xcape
      watchexec
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
  };

  programs.git = {
    enable = true;
    userName = "${name}";
    userEmail = "${email}";
  };


}
