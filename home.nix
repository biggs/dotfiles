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
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

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
    file

    # Modern rust utils
    fd
    ripgrep
    exa
    bat
    gping
    delta
    tealdeer

    # Extra terminal utils.
    imgcat
    calc
    cloc
    htop
    fasd
    cabal2nix
    youtube-dl
    nmap

    exfat

    # Security
    pass
    gnupg
    lesspass-cli

    # Terminal programs
    ncdu
    ranger

    # Pandoc
    pandoc
    # (haskellPackages.callPackage ./extras/pandoc-unicode-math.nix {})  #TODO: Broken.

    jabref

    # Python.
    python-language-server
    (python3.withPackages (ps: with ps; [
      numpy scipy matplotlib scikit-learn
      pyflakes pycodestyle
      # tensorflow
      # pytorchWithCuda
      ipython ipdb seaborn
      # jax (jaxlib.override { cudaSupport = true; })
    ]))

    # Make org-roam work
    sqlite

    # Tex.
    texlive.combined.scheme-full
    # (texlive.combine {
    #     inherit (texlive)
    #         scheme-medium
    #         collection-fontsrecommended
    #         unicode-math
    #         dvipng
    #         subfigure
    #         environ
    #         trimspaces
    #         multirow
    #         cleveref
    #         newunicodechar
    #         xifthen
    #         ifmtarg
    #         enumitem
    #         titlesec
    #         bbm-macros
    #         lastpage
    #         # tabto
    #         totcount
    #         changepage
    #         paracol
    #         # attrib
    #         # upgreek
    #         pbox
    #         tocloft
    #         forloop;
    # })
    rubber
  ];
}
