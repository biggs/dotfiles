{ config, lib, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ../../home.nix ];

  ####   Ubuntu Specific Extras.
  home.packages = with pkgs; [
    # Emacs (ubuntu goodies)
    emacs

    # More ubuntu specific
    feh
    glibcLocales
    qtpass
    rclone
    rclone-browser
    spotify
    watchexec
    xcape
    zathura
    zeal
    zotero
    zulip
  ];

  home.file = {
    ".profile".source = ../ubuntu/profile-ubuntu;
  };
}
