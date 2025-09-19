# nixos/modules/desktop/hyprland.nix
{ pkgs, ... }: {
  # Aktifkan Xwayland untuk kompatibilitas
  services.xserver.enable = true;

  programs = {
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    waybar.enable = true;
    hyprlock.enable = true;
  };

  # Variabel lingkungan esensial untuk Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland; wcb";
    SDL_VIDEODRIVER = "wayland";
  };

  # Layanan lain yang sering dipakai di desktop
  services.openssh.enable = true;
}
