{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    hyprlock
    dmenu-wayland
    firefox
    rofi
  ];

  programs.waybar = {
    enable = true;
  };
}
