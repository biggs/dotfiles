{ config, pkgs, ... }:

let
  # Personal Info
  name = "Felix Biggs";
  email = "felixbig@gmail.com";
  github = "biggs";
in
{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # List of packages to install.
  home.packages = [ # MacOS only.
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
    ".gitignore".source = ../git/gitignore_global;
    ".config/nvim/init.vim".source = ../vim/init.vim;

    # MacOS Only
    ".profile".source = ../mac/profile-mac;
    ".Brewfile".source = ../mac/Brewfile;
  };

  # Generate directory for Info pages.
  programs.info.enable = true;


  programs.git = {
    enable = true;
    userName = "${name}";
    userEmail = "${email}";
    extraConfig.github.user = "${github}";
    extraConfig.core.excludesfile = "~/.gitignore";
    # Note: nix git on mac helpfully adds: credential.helper=osxkeychain
  };

  # programs.fish.enable = true;

}
