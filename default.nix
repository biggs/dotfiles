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
    neovim
    ncdu
    ranger

    # Pandoc
    pandoc
    (haskellPackages.callPackage ./nix/pandoc-unicode-math.nix {})

    # OTHER
    cabal2nix    # Incredibly useful utility.
  ];


  python = (pkgs.python3.withPackages (ps: [ps.numpy]));

  aspell = (pkgs.aspellWithDicts (ps: [ps.en]));  # English spelling for Emacs.

  wifi-password = (pkgs.callPackage /Users/felix/.dotfiles/nix/wifi-password.nix {});

  tex-live = (pkgs.texlive.combine  {
    inherit (pkgs.texlive) scheme-medium collection-fontsrecommended unicode-math;
    });



  my-packs = [
    standardpacks
    python
    aspell
    wifi-password
    tex-live
  ];

in my-packs
