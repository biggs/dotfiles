{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
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
    shellAliases = {
      view = "nvim -R";
      e = "emacsclient --no-wait --quiet --alternate-editor='nvim'";
      vlc = "/Applications/VLC.app/Contents/MacOS/VLC";
      mylint = "pylint --rcfile=~/.dotfiles/python/pylint.rc";
      ca = "command --all";
      cimarronip = "nmap -sL 192.168.1.0/24 | grep cimarron | cut -d' ' -f6 | tr -d '()'";
      brightness = "xrandr --output DP2 --brightness";

      # Exa.
      ls = "exa";
      l = "exa -l --git";
      la = "exa -l -a --git";
      l2 = "exa -l --git -T --level 2";

      # Hide copyright/intro
      gdb = "gdb -q";
      julia = "julia --banner=no";
      calc = "calc -d";
    };
    interactiveShellInit =
      ''
        function fish_prompt
          set duration (math -s6 "$CMD_DURATION / 1000")
          echo ""
          powerline-go \
          -error $status -shell bare -cwd-mode plain -numeric-exit-codes \
          -duration $duration -duration-min 5 \
          -modules "venv,ssh,cwd,git,duration,jobs,exit" -newline
        end
      '';
  };

  home.packages = with pkgs; [
    # Called on startup.
    fortune
    lolcat

    # Prompt.
    powerline-go
  ];

  home.file.".config/fish/conf.d/nix-env.fish".source = ./setup-with-nix.fish;   # Use the file from here: https://github.com/lilyball/nix-env.fish

}
