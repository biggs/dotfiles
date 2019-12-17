{ config, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  ####   Ubuntu Specific Extras.
  home.packages = with pkgs; [
    # Emacs (ubuntu goodies)
    emacs

    # More ubuntu specific
    feh
    glibcLocales   # Fix locales (along with setting in .profile: https://github.com/NixOS/nix/issues/599#issuecomment-131576553)
    qtpass
    rclone
    rclone-browser
    spotify
    watchexec
    xcape
    zathura
    zulip
  ];

  home.file = {
    ".profile".source = ../ubuntu/profile-ubuntu;
  };
}
