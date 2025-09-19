# home/modules/desktop/steam.nix
{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  home.packages = with pkgs; [
    mangohud
    goverlay
    wine
    winetricks
  ];
}
