let
  # Non-pinned nix packages.
  pkgs = import <nixpkgs> {};

  my-pkgs = with pkgs; [

    # nix        # make sure nix is in my path!
    cacert     # certificates for ssh downloads, needed for nix.
    nox      # search nix packages.

    # Basic GNU utils.
    coreutils
    findutils
    diffutils
    gawk
    gnumake
    less
    watch
    git
    wget
    curlFull
    fd

    # Extra terminal utils.
    imgcat
    ripgrep
    calc
    cloc
    exa
    htop
    tldr
    fasd
    powerline-go
    cabal2nix    # Incredibly useful utility.
    youtube-dl

    # Security
    pass
    gnupg
    lesspass-cli

    # Terminal programs
    fish
    fish-foreign-env
    neovim
    ncdu
    ranger

    # Pandoc
    pandoc
    (haskellPackages.callPackage ./pandoc-unicode-math.nix {})

    # Fun starting goodies
    fortune
    lolcat

    # English spelling for Emacs.
    (pkgs.aspellWithDicts (ps: [ps.en]))

    # Python.
    (python3.withPackages (ps: [ps.numpy ps.python-language-server]))

    # Tex.
    (texlive.combine {
        inherit (texlive) scheme-medium collection-fontsrecommended unicode-math dvipng subfigure forloop;
    })
  ];


in my-pkgs
