# nixos/modules/desktop/sddm.nix
{ pkgs, ... }: {
  services.libinput.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "hyprland";
  };
}
