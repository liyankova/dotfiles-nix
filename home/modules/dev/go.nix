# home/modules/development/go.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    gotools
    delve
  ];
}
