{ config, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  ####   Ubuntu Specific Extras.
  home.packages = with pkgs; [
    # Emacs (ubuntu goodies)
    emacs

    # More ubuntu specific
    xcape
    watchexec
    anki
    qtpass
    spotify
    glibcLocales   # Fix locales (along with setting in .profile: https://github.com/NixOS/nix/issues/599#issuecomment-131576553)
    feh
  ];

  home.file = {
    ".profile".source = ../ubuntu/profile-ubuntu;
  };
}
