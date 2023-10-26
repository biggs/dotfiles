{ config, lib, pkgs, ... }:

{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia" "intel"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}

# ARCHIVED SETTINGS
# -----------------
#
# services.xserver.videoDrivers = [ "intel" "nvidia" ];
# # NVIDIA + docker Add nvidia driver to currently selected (config) kernel package.
# # https://github.com/NixOS/nixpkgs/pull/51733#issuecomment-464160791
# virtualisation.docker.enable = true;
# virtualisation.docker.enableNvidia = true;
# boot.extraModulePackages = with config.boot.kernelPackages; [ nvidia_x11 ];
# hardware.opengl.enable = true;
# hardware.opengl.driSupport32Bit = true;
# hardware.opengl.driSupport = true;
# hardware.opengl.extraPackages = [
#     pkgs.mesa.drivers
#     pkgs.linuxPackages.nvidia_x11.out
#     pkgs.libglvnd
# ];
# # HACK: make nvidia work?
# systemd.enableUnifiedCgroupHierarchy = false;
# boot.kernelModules = [ "nvidia" ];
