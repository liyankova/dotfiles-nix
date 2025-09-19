# home/modules/desktop/tools-wayland.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Wayland Core
    wl-clipboard
    cliphist
    grim
    slurp
    swappy
    swww
    brightnessctl

    # App Launcher / Bar
    rofi-wayland # More modern than rofi
    wlogout
    swaynotificationcenter

    # Theming & System Tools
    nwg-look
    btop
    cava
    inxi
    duf
    baobab # GNOME Disk Usage Analyzer
  ];
  
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # For GUI password prompts (e.g., sudo in terminal)
  services.gpg-agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
