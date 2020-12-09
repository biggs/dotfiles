{ config, pkgs, ... }:

{
  imports = [
    ./git/git.nix
    ./fish/fish.nix
    ./vim/vim.nix
    ./emacs/emacs.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set nixpkgs options (for home-manager installed packages only).
  nixpkgs.config = { allowUnfree = true; };

  # Documentation!
  programs.man.enable = true;
  programs.info.enable = true;

  # Packages.
  home.packages = with pkgs; [
    # Nix
    cacert     # certificates for ssh downloads, needed for nix.
    nix-prefetch-git     # get git revision hash.

    # Basic GNU utils.
    coreutils
    findutils
    diffutils
    gawk
    gnumake
    less
    watch
    wget
    curlFull
    fd
    file

    # Extra terminal utils.
    imgcat
    ripgrep
    calc
    cloc
    exa
    htop
    tldr
    fasd
    cabal2nix
    youtube-dl
    bat
    nmap

    # Security
    pass
    gnupg
    lesspass-cli

    # Terminal programs
    ncdu
    ranger

    # Pandoc
    pandoc
    # (haskellPackages.callPackage ./pandoc-unicode-math.nix {})  #TODO: Broken.

    # Python.
    (python3.withPackages (ps: with ps; [
      numpy python-language-server scipy matplotlib
    ]))

    # Tex.
    (texlive.combine {
        inherit (texlive)
            scheme-medium
            collection-fontsrecommended
            unicode-math
            dvipng
            subfigure
            environ
            trimspaces
            multirow
            cleveref
            lipsum
            forloop;
    })
    rubber
  ];
}
