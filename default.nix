let
  # Non-pinned nix packages.
  pkgs = import <nixpkgs> {};

  my-pkgs = with pkgs; [
    nix        # make sure nix is in my path!
    cacert     # certificates for ssh downloads, needed for nix.
    # nox      # search nix packages.

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
    powerline-go

    # Terminal programs
    fish
    fish-foreign-env
    neovim
    ncdu
    ranger

    # Pandoc
    pandoc
    (haskellPackages.callPackage ./nix/pandoc-unicode-math.nix {})

    # OTHER
    cabal2nix    # Incredibly useful utility.
    youtube-dl

    # Fun starting goodies
    fortune
    lolcat

    # MacOS only.
    darwin.trash
    wifi-password

    # English spelling for Emacs.
    (pkgs.aspellWithDicts (ps: [ps.en]))

    # Python.
    (python3.withPackages (ps: [ps.numpy]))

    # Tex.
    (texlive.combine {
        inherit (texlive) scheme-medium collection-fontsrecommended unicode-math dvipng;
    })

    docker
  ];


in my-pkgs
