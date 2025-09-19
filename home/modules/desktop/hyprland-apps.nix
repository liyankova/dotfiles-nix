{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    dmenu-wayland
    firefox
    rofi
  ];

  programs.waybar = {
    enable = true;
  };
  


}
