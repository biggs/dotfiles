{ config, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ./core.nix ];

  ####  MacOS Specific Extras.
  home.packages = with pkgs; [
    darwin.trash
    wifi-password
    qtpass

    fish-foreign-env   # Needed for import of .profile
  ];

  home.file = {
    ".Brewfile".source = ../mac/Brewfile;

    # Get correct PATH and nix setup for macos. (note escaping '' in front of $)
    ".profile".text = ''
      # First line is Mac default PATH, nix additions in other lines.
      export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
      if [ -e /Users/felix/.nix-profile/etc/profile.d/nix.sh ]; \
      then . /Users/felix/.nix-profile/etc/profile.d/nix.sh; fi
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    '';
  };
}
