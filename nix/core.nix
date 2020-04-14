{ config, pkgs, ... }:

let
  # Personal Info
  name = "Felix Biggs";
  email = "felixbig@gmail.com";
  github = "biggs";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set nixpkgs options (for home-manager installed packages only).
  nixpkgs.config = { allowUnfree = true; };

  # Emacs setup. Re-tangle doom config on rebuild (breaks goto doom-private-dir).
  home.file = {
    ".config/doom" = {
      source = ../emacs;
      recursive = true;
      onChange = ''~/.emacs.d/bin/doom refresh'';
    };
  };

  # Generate directory for Info pages.
  programs.info.enable = true;

  programs.git = {
    enable = true;
    userName = "${name}";
    userEmail = "${email}";
    extraConfig.github.user = "${github}";
    extraConfig.core.excludesfile = builtins.toString ../git/gitignore_global;
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
    viAlias = true;
  };


  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ../fish/config.fish;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];
  };


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
    ncdu
    ranger

    # Pandoc
    pandoc
    # (haskellPackages.callPackage ./pandoc-unicode-math.nix {})  #TODO: Broken.

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
