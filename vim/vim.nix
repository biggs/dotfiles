{ config, lib, pkgs, ... }:

{
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
        copilot-vim
      ]);
    extraConfig = builtins.readFile ./init.vim;
    viAlias = true;
  };

  home.packages = [ pkgs.nodejs ];   # Used by copilot
}
