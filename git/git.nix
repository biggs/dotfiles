{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "biggs";
    userEmail = "felixbig@gmail.com";
    extraConfig.github.user = "biggs";
    extraConfig.core.excludesfile = builtins.toString ./gitignore_global;
    # Note: nix git on mac helpfully adds: credential.helper=osxkeychain
  };
}
