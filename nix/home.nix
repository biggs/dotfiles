{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # List of packages to install.
  home.packages = import ./default.nix;
}
