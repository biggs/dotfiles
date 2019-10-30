let
  # Non-pinned nix packages.
  pkgs = import <nixpkgs> {};

  # My packages from nixpkgs.
  standardpacks = with pkgs; [
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

    # MacOS only.
    darwin.trash
    wifi-password
  ];


  python = (pkgs.python3.withPackages (ps: [ps.numpy]));

  aspell = (pkgs.aspellWithDicts (ps: [ps.en]));  # English spelling for Emacs.

  tex-live = (pkgs.texlive.combine  {
    inherit (pkgs.texlive) scheme-medium collection-fontsrecommended unicode-math;
    });



  my-packs = [
    standardpacks
    python
    aspell
    tex-live
  ];

in my-packs
