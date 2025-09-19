{ config, lib, pkgs, host, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/system/bootloader.nix
      ../../modules/system/core.nix
      ../../modules/system/networking.nix

      # Modul Hardware
      # ../../modules/hardware/nvidia.nix
      ../../modules/services/audio.nix
      ../../modules/desktop/sddm.nix
      ../../modules/desktop/hyprland.nix
      (lib.mkIf host.hasNvidia ../../modules/hardware/nvidia.nix)
    ];
	#  services.libinput.enable = true;
	#  services.displayManager = {
	#    sddm = {
	#      enable = true;
	#      wayland.enable = true;
	#      };
	#    defaultSession = "hyprland";
	#  };
	#
	#  services.xserver.enable = true;
	#  services.pipewire = {
	#    enable = true;
	#    pulse.enable = true;
	#  };
	#
	#  programs = {
	#    hyprland = {
	#      enable = true;
	#      # wayland.enable = true;
	#      xwayland.enable = true;
	#      # portalPackages = pkgs.xdg-desktop-portal-hyprland;
	#    };
	#    waybar.enable = true;
	#    hyprlock.enable = true;
	#    firefox.enable = true;
	#    mtr.enable = true;
	# #    xdg.portal = {
	# #      enable = true;
	# #      wlr.enable = false;
	# #      extraPortals = with pkgs; [
	# #        xdg-desktop-portal-gtk
	# # ];
	# # };
	#  };
	#
	#  environment.sessionVariables = {
	#    NIXOS_OZONE_WL = "1";
	#    MOZ_ENABLE_WAYLAND = "1";
	#    QT_QPA_PLATFORM = "wayland; wcb";
	#    SDL_VIDEODRIVER = "wayland";
	#    };
	#
	#
	#  services.openssh.enable = true;
	#
  system.stateVersion = "25.05"; 

}

