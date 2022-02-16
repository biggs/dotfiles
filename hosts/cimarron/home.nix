{ config, lib, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ../../home.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "felix";
  home.homeDirectory = "/home/felix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = with pkgs; [

    anki
    gcc
    glibcLocales   # FIX LOCALES
    qtpass
    spotify
    xcape
    zathura
    zeal
    zotero

    pciutils
    glxinfo

    alacritty
    pavucontrol   # pulseaudio controller

    keepassxc
    transmission-gtk

    texlive.combined.scheme-full
    python-language-server
    jabref
  ];


  programs.fish = {
    shellAliases = {
      battery = "echo 'mouse'; cat /sys/class/power_supply/hid-84:fc:fe:f3:63:db-battery/capacity; echo 'keyboard'; cat /sys/class/power_supply/hid-28:37:37:2e:8f:e4-battery/capacity";
    };
  };
}
