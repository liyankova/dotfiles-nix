# home/modules/desktop/apps.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Media
    spotify
    vlc
    mpv
    yt-dlp
    
    # Creative & Productivity
    obsidian
    krita
    gimp
    inkscape
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-archive-plugin
    # Communication (using unstable for latest versions)
    # (pkgs.unstable.discord)
    # (pkgs.unstable.slack)
    # (pkgs.unstable.teams)
    # (pkgs.unstable.zoom-us)
  ];

  programs.firefox.enable = true;
}
