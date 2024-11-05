{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = (with pkgs.vimPlugins;
      [
        # ack-vim  # ag integration
        vim-surround  # interact cleverly with surrounding brackets etc
        vim-repeat  # allow plugins to repeat with .
        vim-unimpaired # extra bindings, really useful
        vim-commentary  # lightweight comment toggle with gc+motion
        # rhysd/conflict-marker.vim  # mark git conflicts
        # jiangmiao/auto-pairs  # auto brackets
        vim-bufferline  # show buffers in statusbar
        undotree  # navigable undo
        vim-over  # highlighting during :s/blah
        rainbow  # rainbow parentheses
        # myusuf3/numbers.vim  # relative/non line number mode toggle
        vim-monokai-tasty  # Colorscheme
        vim-airline  # Cool status bar
        vim-airline-themes
        vim-gitgutter  # Git change line marks
        # copilot-vim
      ]);
    viAlias = true;

    # This is clever, it creates a file in the nix store symlinking init.vim in .dotfiles; it also adds a line to vimconfig inside nix store telling it to source that file; therefore we can edit vimconfig without refreshing home-manager.
    extraConfig = ''
      source ${config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/vim/init.vim"}
    '';
  };

#  home.packages = [ pkgs.nodejs ];   # Used by copilot
}
