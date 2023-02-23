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

  programs.mpv.enable = true;
  programs.mpv.config = {
    profile = "gpu-hq";
    vo = "gpu";
    force-window = true;
    ytdl-format = "bestvideo+bestaudio";
  };

  programs.gpg.enable = true;

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
    pinentry
    unzip

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
    ncdu
    ranger

    exfat

    # Security
    pass
    gnupg
    lesspass-cli

    # Python.
    (python3.withPackages (ps: with ps; [
      # numpy scipy matplotlib scikit-learn
      # pyflakes pycodestyle
      # tensorflow
      # pytorchWithCuda
      # ipython ipdb seaborn
      # jupyter
      # jax (jaxlib.override { cudaSupport = true; })
    ]))

    # Make org-roam work
    sqlite

    # Related to writing papers etc.
    pandoc
    # (haskellPackages.callPackage ./extras/pandoc-unicode-math.nix {})  #TODO: Broken.
    rubber
    poppler_utils
  ];
}
