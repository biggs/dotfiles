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

  python = (pkgs.python3.withPackages (ps: [ps.numpy]));

  # Packages with special customisations.
  custompacks = [
    python
  ];

  mypacks = nixpacks ++ custompacks;

in mypacks
