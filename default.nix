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
    watch
    git

    # Extra terminal utils.
    wget
    curlFull
    imgcat
    ripgrep
    calc
    cloc
    exa
    htop
    tldr
    fasd

    # Terminal programs
    fish
    neovim
    ncdu
    ranger

    # Terminal fun
    powerline-go

    # OTHER
    aspell   # For emacs
    pandoc  # NOTE: this takes a long time to install because Haskell.
  ];


  # Packages with special customisations.
  python = (pkgs.python3.withPackages (ps: [ps.numpy]));
  aspell = (pkgs.aspellWithDicts (ps: [ps.en]));  # for emacs, with English.

  custompacks = [
    python
    aspell
  ];

  mypacks = nixpacks ++ custompacks;

in mypacks
