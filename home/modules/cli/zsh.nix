# home/modules/cli/zsh.nix
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    # We will add more zsh config here later
  };
}
