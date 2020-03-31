{ config, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  ####  MacOS Specific Extras.
  home.packages = with pkgs; [
    darwin.trash
    wifi-password
    qtpass
  ];

  home.file = {
    ".profile".source = ../mac/profile-mac;
    ".Brewfile".source = ../mac/Brewfile;
  };
}
