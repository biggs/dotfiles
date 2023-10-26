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
  system.stateVersion = "20.09"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;

  # Time zone and location.
  time.timeZone = "Europe/London";
  location.provider = "geoclue2";

  # Booting Config.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;    # better security.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Basic networking + enable ssh.
  networking.hostName = "cimarron";
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp8s0.useDHCP = true;
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
    defaultLocale = "en_GB.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    wget vim git curl firefox emacs dropbox-cli termite xcape
  ];

  services.emacs.defaultEditor = true;

  fonts.fonts = with pkgs; [
    source-code-pro
    powerline-fonts
    emacs-all-the-icons-fonts
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Nighttime dimming
  services.redshift = {
    enable = true;
    brightness = {
      # Note the string values below.
      day = "1";
      night = "0.5";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  # enable locate database updates
  services.locate.enable = true;
  services.locate.interval = "2hours";

 
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "mac";   # Make mac keyboard work.
  services.xserver.xkbOptions = "ctrl:nocaps";   # rules in X11/xkb/rules/base
  # services.xserver.displayManager.sessionCommands = "xcape &";   # tap caps for esc
  console.useXkbConfig = true;   # Console gets same config.


  # i3
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.exportConfiguration = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  boot.kernelModules = [ "kvm-intel" "nvidia" ];
  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  # NVIDIA + docker Add nvidia driver to currently selected (config) kernel package.
  # https://github.com/NixOS/nixpkgs/pull/51733#issuecomment-464160791
  hardware.opengl.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ nvidia_x11 ];
  virtualisation.docker.enable = true;
  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker.enableNvidia = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [
      pkgs.mesa.drivers
      pkgs.linuxPackages.nvidia_x11.out
      pkgs.libglvnd
  ];

  # HACK: make nvidia work?
  systemd.enableUnifiedCgroupHierarchy = false;

  # Brighness controls
  hardware.i2c.enable = true;

  # Define my user account. Must set password using 'passwd felix'.
  users.users.felix = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "systemd-journal" "audio" "networkmanager" ];
  };

  # Allow sudo shutdown/reboot etc. without password.
  # systemctl poweroff/hibernate etc. are enabled for local users already.
  security.sudo.extraConfig = ''
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/poweroff
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/reboot
  '';

  # Enable full blown magic sysrq.
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  # Make magic mouse work.
  boot.extraModprobeConfig = "options hid_magicmouse scroll_acceleration=1 scroll_speed=55 emulate_3button=0";


}
