{ config, lib, pkgs, host, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      # System
      ../../modules/system/bootloader.nix
      ../../modules/system/core.nix
      ../../modules/system/networking.nix

      # Modul Hardware
      ../../modules/hardware/nvidia.nix

      # Services
      ../../modules/services/audio.nix
      
      # Desktop
      ../../modules/desktop/sddm.nix
      ../../modules/desktop/hyprland.nix
      ../../modules/desktop/thunar.nix
      ../../modules/desktop/steam.nix
      # (lib.mkIf host.hasNvidia ../../modules/hardware/nvidia.nix)
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  system.stateVersion = "25.05"; 

}

