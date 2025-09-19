# home/modules/desktop/hyprland-apps.nix
{ pkgs, ... }:

{
  # Wayland programs that benefit from unstable
  home.packages = with pkgs.unstable; [
    waybar
    hyprlock
    dmenu-wayland # rofi-wayland is a more modern alternative
    firefox
  ];

  # We manage Waybar through Home Manager's service
  programs.waybar = {
    enable = true;
    # We can define settings and style here later
  };
}
