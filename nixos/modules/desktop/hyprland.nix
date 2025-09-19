# nixos/modules/desktop/hyprland.nix
{ pkgs, ... }: 
{

  services.xserver.enable = true;

  programs = {
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    hyprlock.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland; wcb";
    SDL_VIDEODRIVER = "wayland";
  };

  services.openssh.enable = true;
}
