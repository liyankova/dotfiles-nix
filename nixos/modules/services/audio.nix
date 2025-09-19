# nixos/modules/services/audio.nix
{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
