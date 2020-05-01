{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./dropbox.nix
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/London";

  # Booting Config.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;    # better security.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Basic networking + enable ssh.
  networking.hostName = "cimarron";
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp8s0.useDHCP = true;
  services.openssh.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  environment.systemPackages = with pkgs; [
    wget vim git curl firefox emacs dropbox-cli termite steam xcape
  ];

  fonts.fonts = with pkgs; [
    source-code-pro
    powerline-fonts
    emacs-all-the-icons-fonts
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

 
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "ctrl:swapcaps";
  services.xserver.displayManager.sessionCommands = "xcape &";   # tap caps for esc.
  console.useXkbConfig = true;   # Console gets same config.

  # i3
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.exportConfiguration = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  # Swap between the below lines for nvidia or opengl support
  services.xserver.videoDrivers = [ "intel" "nvidia" ];  # enable if want nvidia to work
  # services.xserver.videoDrivers = [ "intel" ];  # enable if want opengl to work

  # NVIDIA + docker Add nvidia driver to currently selected (config) kernel package.
  # https://github.com/NixOS/nixpkgs/pull/51733#issuecomment-464160791
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ nvidia_x11 ];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [
      pkgs.libGL_driver
      pkgs.linuxPackages.nvidia_x11.out
      pkgs.libglvnd
  ];


  # Define my user account. Must set password using 'passwd felix'.
  users.users.felix = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "systemd-journal" "audio" ];
  };

  # Allow sudo shutdown/reboot etc. without password.
  security.sudo.extraConfig = ''
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/poweroff
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/reboot
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl suspend
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl hibernate
  '';

  # Enable full blown magic sysrq.
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  # Swapfile + hibernation
  # https://discourse.nixos.org/t/is-it-possible-to-hibernate-with-swap-file/2852
  swapDevices = [ { device = "/var/swapfile"; size = 32768; } ];
  boot.kernelParams = [ "resume_offset=6025216" ];
  boot.resumeDevice = "/dev/disk/by-uuid/7d191f35-3fb7-4756-9b7f-d769135fa027";
}
