{ config, lib, pkgs, host, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # --- Core System Modules ---
    ../../modules/system/core.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix

    # --- Conditional Modules based on Tags ---
    (lib.mkIf (lib.elem "desktop" host.tags) ../../modules/services/audio.nix)
    (lib.mkIf (lib.elem "desktop" host.tags) ../../modules/desktop/sddm.nix)
    (lib.mkIf (lib.elem "desktop" host.tags) ../../modules/desktop/hyprland.nix)
    (lib.mkIf (lib.elem "desktop" host.tags) ../../modules/desktop/thunar.nix)
    
    (lib.mkIf (lib.elem "nvidia" host.tags) ../../modules/hardware/nvidia.nix)
    (lib.mkIf (lib.elem "gaming" host.tags) ../../modules/desktop/steam.nix)
    (lib.mkIf (lib.elem "btrfs" host.tags) ../../modules/system/btrfs.nix)
  ];

  # Global build settings for this host
  nixpkgs.config.nvidia.acceptLicense = lib.mkIf (lib.elem "nvidia" host.tags) true;

  system.stateVersion = "25.05";
}

# { config, lib, pkgs, host, ... }:
#
# {
#   imports =
#     [ 
#       ./hardware-configuration.nix
#
#       # System
#       ../../modules/system/bootloader.nix
#       ../../modules/system/core.nix
#       ../../modules/system/networking.nix
#       ../../modules/system/btrfs.nix
#
#       # Modul Hardware
#       ../../modules/hardware/nvidia.nix
#
#       # Services
#       ../../modules/services/audio.nix
#
#       # Desktop
#       ../../modules/desktop/sddm.nix
#       ../../modules/desktop/hyprland.nix
#       ../../modules/desktop/thunar.nix
#       ../../modules/desktop/steam.nix
#       # (lib.mkIf host.hasNvidia ../../modules/hardware/nvidia.nix)
#     ];
#
#   nixpkgs.config.allowUnfree = true;
#   nixpkgs.config.nvidia.acceptLicense = true;
#   system.stateVersion = "25.05"; 
#
# }

