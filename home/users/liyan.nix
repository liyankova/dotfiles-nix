{ pkgs, ... }: 
{

  imports = [

    # CLI
    ../modules/cli/tools.nix
    ../modules/cli/zsh.nix
    ../modules/cli/git.nix

    # Desktop
    ../modules/desktop/hyprland-apps.nix
    ../modules/desktop/apps.nix
    ../modules/desktop/tools-wayland.nix
    ../modules/desktop/steam.nix

    # Dev
    ../modules/dev/go.nix
    ../modules/dev/nodejs.nix
    ../modules/dev/rust.nix
    ../modules/dev/editors.nix
    ../modules/dev/android.nix

    # System
    ../modules/system/fonts.nix
    # ../modules/dotfiles.nix
  ];
  home.username = "liyan";
  home.homeDirectory = "/home/liyan";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
