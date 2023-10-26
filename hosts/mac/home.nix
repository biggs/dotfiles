{ config, pkgs, pkgs-stable, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "felix";
  home.homeDirectory = "/Users/felix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";


  imports = [ ../../home.nix ];

  home.packages = with pkgs; [
    pkgs-stable.emacs
    darwin.trash
    wifi-password
    qtpass

    fishPlugins.foreign-env    # Needed for import of .profile

    pkgs-stable.texlive.combined.scheme-full
    # (texlive.combine {
    #   inherit (texlive)
    #     scheme-medium
    #     cleveref
    #     hyperref
    #     natbib
    #     expdlist
    #     todonotes
    #     environ
    #     subfigure
    #     forloop
    #     collection-fontsrecommended
    #     ebgaramond
    #     multirow
    #     tcolorbox
    #     enumitem
    #     titlesec
    #     fontaxes
    #     geometry
    #     arev
    #     bera
    #     nag
    #     blindtext
    #     emptypage
    #     placeins
    #     xpatch
    #     bbm bbm-macros
    #     appendix
    #     wrapfig
    #     a0poster;
        # unicode-math
        # dvipng
        # environ
        # trimspaces
        # multirow
        # newunicodechar
        # xifthen
        # ifmtarg
        # enumitem
        # titlesec
      # })


    (python3.withPackages (ps: with ps; [
      numpy
      matplotlib
      ipython ipdb
      tqdm
      pyflakes
      pycodestyle
    ]))

  ];



  home.file = {
    ".Brewfile".source = ./Brewfile;
  };
}
