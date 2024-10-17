{ config, pkgs, pkgs-stable, ... }:
{
  imports = [
    ../../home-shared.nix
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.cudaSupport = false;

  home.homeDirectory = "/home/felix.biggs";
  home.username = "felix.biggs";

  # Packages.
  home.packages = with pkgs; [
    poetry
    xcape
    powerline-fonts
  ];
}

