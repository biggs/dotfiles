{ config, lib, pkgs, ... }:

{
  # Import everything from sub-files.
  imports = [ ../../home.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "felix";
  home.homeDirectory = "/home/felix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = with pkgs; [

    anki-bin
    gcc
    glibcLocales   # FIX LOCALES
    qtpass
    spotify
    xcape
    zeal
    zotero

    pciutils
    glxinfo

    alacritty     # terminal
    pavucontrol   # pulseaudio controller
    ddcutil       # monitor brightness control

    keepassxc
    transmission-gtk

    texlive.combined.scheme-full
    python-language-server

    (python3.withPackages (ps: with ps; [
      numpy scipy matplotlib scikit-learn
      pyflakes pycodestyle
      jupyterlab ipywidgets
      # tensorflow
      # pytorchWithCuda
      ipython ipdb seaborn
      tqdm
      jax jaxlibWithCuda
    ]))
    # jabref
  ];


  programs.fish = {
    shellAliases = {
      battery = "echo 'mouse'; cat /sys/class/power_supply/hid-84:fc:fe:f3:63:db-battery/capacity; echo 'keyboard'; cat /sys/class/power_supply/hid-28:37:37:2e:8f:e4-battery/capacity";
    };
    functions = {
      brightness = ''
        # Get current brightness
        set currentBrightness (ddcutil getvcp 10 -t | string split " " | tail -n 2 | head -n 1)

        # Change brightness based on argument
        if test "$argv[1]" = "up"
            set newBrightness (math $currentBrightness + 25)
            if test $newBrightness -gt 100
                set newBrightness 100
            end
        else if test "$argv[1]" = "down"
            set newBrightness (math $currentBrightness - 25)
            if test $newBrightness -lt 0
                set newBrightness 0
            end
        else
            echo "Invalid argument. Please use 'up' or 'down'."
            exit 1
        end

        # Set new brightness
        ddcutil setvcp 10 $newBrightness
      '';
    };
  };

  programs.zathura = {
    enable = true;
    extraConfig = ''
      set synctex true
      set synctex-editor-command "emacsclient --no-wait +%{line} %{input}"
    '';
  };

  programs.gh = {
    enable = true;
  };

  services.xcape.enable = true;

  # HACK: temporary fix for texlive not compiling.
  nixpkgs.overlays = [
    (final: prev: {
      clisp = prev.clisp.override {
        # On newer readline8 fails as:
        #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
        #   does not have the required size or alignment
        readline = pkgs.readline6;
      };
    })
  ];
}
