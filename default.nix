let
  # Non-pinned nix packages.
  pkgs = import <nixpkgs> {};

  # My packages.
  nixpacks = with pkgs; [
    nix   # make sure nix is in my path!
    cacert   # certificates for ssh downloads, needed for nix.

    # Basic GNU utils.
    coreutils
    findutils
    diffutils
    gawk
    gnumake
    less

    # Useful terminal utils.
    wget
    curlFull
    imgcat
    ripgrep
    calc
    cloc
  ];

  # Packages with special customisations.
  custompacks = [
  ];

  mypacks = nixpacks ++ custompacks;

in mypacks
