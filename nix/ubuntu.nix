{ config, pkgs, ... }:

with import <nixpkgs> {};

let
  # Personal Info
  name = "Felix Biggs";
  email = "felixbig@gmail.com";
in
{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set nixpkgs options (for home-manager installed packages only).
  nixpkgs.config = { allowUnfree = true; };

  # List of packages to install.
  home.packages = with pkgs; [
                    # Emacs (ubuntu goodies)
                    emacs

                    # More ubuntu specific
                    xcape
                    watchexec
                    anki
                    qtpass
                    spotify
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
