{ config, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

  home.packages = with pkgs; [

    anki
    glibcLocales   # FIX LOCALES
    qtpass
    spotify
    xcape
    zathura
    zeal
    zotero

    pciutils

  ];

  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ../fish/config.fish;
  };

}
