{ config, lib, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/sway/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/sway/config";

  home.file."${config.xdg.configHome}/waybar/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/sway/waybar_config";

  home.file."${config.xdg.configHome}/waybar/style.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/sway/waybar_style.css";
}
