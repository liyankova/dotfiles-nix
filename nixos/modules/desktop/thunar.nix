# nixos/modules/desktop/thunar.nix
{ pkgs, ... }:

{
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.tumbler.enable = true;
  services.gvfs.enable = true;
}
