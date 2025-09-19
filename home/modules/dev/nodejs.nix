# home/modules/development/nodejs.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_20
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.eslint
  ];
}
