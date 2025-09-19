{ pkgs, ... }: 
{

  imports = [
    ../modules/cli/tools.nix
    ../modules/cli/zsh.nix
    ../modules/desktop/hyprland-apps.nix
  ];
  home.username = "liyan";
  home.homeDirectory = "/home/liyan";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
