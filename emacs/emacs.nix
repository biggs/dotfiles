{ config, lib, pkgs, ... }:

{
  # Dotfiles. Re-tangle doom config on rebuild (breaks goto doom-private-dir).
  home.file = {
    ".config/doom" = {
      source = ../emacs;
      recursive = true;
      onChange = ''~/.emacs.d/bin/doom sync'';
    };
  };

  home.packages = with pkgs; [
    # English spelling for Emacs.
    (pkgs.aspellWithDicts (ps: [ps.en]))

    # Roam graph viewer.
    graphviz
  ];
}
