{ config, pkgs, lib, ... }:

{
  # Enable unfree packages (required for NVIDIA drivers)
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Enable OpenGL and 32-bit support for gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable OpenGL (legacy, for compatibility)
  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  #   extraPackages = with pkgs; [ vaapiVdpau ];
  # };

  # Use NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA configuration
  hardware.nvidia = {
  
    # Modesetting is required for hybrid graphics
    modesetting.enable = true;

    # Power management
    powerManagement.enable = true;
    powerManagement.finegrained = false; # MX130 doesn't support this

    # Use proprietary driver (open source not supported on MX130)
    open = false;

    # Enable nvidia-settings GUI
    nvidiaSettings = true;

    # Use stable driver package
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  # package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

    # PRIME configuration for hybrid graphics
    prime = {
      # Sync mode: dGPU handles all rendering, better for gaming
      sync.enable = true;

      # Bus IDs - sesuaikan jika perlu
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Load kernel modules
  boot.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}

