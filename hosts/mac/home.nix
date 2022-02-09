{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "felix";
  home.homeDirectory = "/Users/felix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";


  imports = [ ../../home.nix ];

  home.packages = with pkgs; [
    emacsMacport
    darwin.trash
    wifi-password
    qtpass

    fishPlugins.foreign-env    # Needed for import of .profile

    (texlive.combine {
      inherit (texlive)
        scheme-medium
        cleveref
        hyperref
        natbib
        expdlist
        collection-fontsrecommended;
        # unicode-math
        # dvipng
        # subfigure
        # environ
        # trimspaces
        # multirow
        # newunicodechar
        # xifthen
        # ifmtarg
        # enumitem
        # titlesec
        # forloop;
      })

  ];

  home.file = {
    ".Brewfile".source = ./Brewfile;

    # Get correct PATH and nix setup for macos. (note escaping '' in front of $)
    ".profile".text = ''
      # Set Mac default PATH
      export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

      # Nix setup.
	if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
	fi
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
