{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home.packages = with pkgs; [
    emacsMacport
    darwin.trash
    wifi-password
    qtpass

    fish-foreign-env   # Needed for import of .profile
  ];

  home.file = {
    ".Brewfile".source = ./Brewfile;

    # Get correct PATH and nix setup for macos. (note escaping '' in front of $)
    ".profile".text = ''
      # Set Mac default PATH
      export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

      # Nix setup.
      if [ -e /Users/felix/.nix-profile/etc/profile.d/nix.sh ]; \
      then . /Users/felix/.nix-profile/etc/profile.d/nix.sh; fi
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH

      # Seems like these not automagically set by Nix.
      export INFOPATH="$HOME/.nix-profile/share/info/:''${INFOPATH:+:}$INFOPATH"
      export MANPATH="$HOME/.nix-profile/share/man/:''${MANPATH:+:}$MANPATH"

      # Basic Homebrew settings.
      export HOMEBREW_PREFIX="/usr/local";
      export HOMEBREW_CELLAR="/usr/local/Cellar";
      export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
      export PATH="/usr/local/bin:/usr/local/sbin''${PATH+:$PATH}";
      export MANPATH="/usr/local/share/man''${MANPATH+:$MANPATH}:";
      export INFOPATH="/usr/local/share/info''${INFOPATH+:$INFOPATH}";
    '';
  };
}
