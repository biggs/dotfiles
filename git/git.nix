{ config, lib, pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "biggs";
    userEmail = "felixbig@gmail.com";
    delta.enable = true;
    extraConfig.github.user = "biggs";
    extraConfig.core.excludesfile = builtins.toString ./gitignore_global;
    # Note: nix git on mac helpfully adds: credential.helper=osxkeychain
  };
}
