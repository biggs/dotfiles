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

  # Vim
  programs.neovim = {
    enable = true;
    plugins = (with pkgs.vimPlugins;
      [
        ack-vim  # ag integration
        vim-surround  # interact cleverly with surrounding brackets etc
        vim-repeat  # allow plugins to repeat with .
        vim-unimpaired # extra bindings, really useful
        vim-commentary  # lightweight comment toggle with gc+motion
        # rhysd/conflict-marker.vim  # mark git conflicts
        # jiangmiao/auto-pairs  # auto brackets
        vim-bufferline  # show buffers in statusbar
        undotree  # navigable undo
        # osyo-manga/vim-over  # highlighting during :s/blah
        rainbow  # rainbow parentheses
        # myusuf3/numbers.vim  # relative/non line number mode toggle
        molokai  # Colorscheme
        vim-airline  # Cool status bar
        vim-airline-themes
        vim-gitgutter  # Git change line marks
      ]);
    extraConfig = builtins.readFile ../vim/init.vim;
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
    (python3.withPackages (ps: with ps; [
      numpy python-language-server
      tensorflow tensorflow-tensorboard tensorflow-probability
    ]))

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
