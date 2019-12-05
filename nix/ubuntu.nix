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
  ];
}
