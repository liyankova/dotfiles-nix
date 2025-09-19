# home/modules/desktop/tools-wayland.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Wayland Core
    wl-clipboard cliphist grim slurp swappy swww brightnessctl

    # App Launcher / Bar
    # rofi-wayland # More modern than rofi
    wlogout swaynotificationcenter 

    # Audio Control
    pamixer pavucontrol

    # Theming & System Tools
    nwg-look btop cava inxi duf baobab
  ];  
}
