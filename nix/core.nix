{ config, pkgs, ... }:

let
  # Personal Info
  name = "Felix Biggs";
  email = "felixbig@gmail.com";
  github = "biggs";
  dotdir = ~/.dotfiles;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set nixpkgs options (for home-manager installed packages only).
  nixpkgs.config = { allowUnfree = true; };

  # Link dotfiles into place.
  home.file = {
    # Re-tangle doom config on rebuild (breaks goto doom-private-dir).
    ".config/doom" = {
      source = dotdir + "/emacs";
      recursive = true;
      onChange = ''~/.emacs.d/bin/doom refresh'';
    };

    ".gitignore".source = dotdir + "/git/gitignore_global";
    ".config/nvim/init.vim".source = dotdir + "/vim/init.vim";
  };

  # Generate directory for Info pages.
  programs.info.enable = true;

  programs.git = {
    enable = true;
    userName = "${name}";
    userEmail = "${email}";
    extraConfig.github.user = "${github}";
    extraConfig.core.excludesfile = "~/.gitignore";
    # Note: nix git on mac helpfully adds: credential.helper=osxkeychain
  };

  home.packages = with pkgs; [
    cacert     # certificates for ssh downloads, needed for nix.

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
    cabal2nix
    youtube-dl
    bat
    nmap

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
        inherit (texlive)
            scheme-medium
            collection-fontsrecommended
            unicode-math
            dvipng
            subfigure
            forloop;
    })
  ];
}
