# system/audio.nix
{ config, pkgs, lib, ... }:

let
  python-packages = pkgs.python3.withPackages (ps: with ps; [
    requests
    pyquery
  ]);
in
{
  # Modern audio stack
  # sound.enable = false;  # Disable legacy ALSA
  services.pulseaudio.enable = false;  # Disable PulseAudio

  # Enable PipeWire + WirePlumber
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Audio tools
  environment.systemPackages = with pkgs; [
    wireplumber
    pipewire
    python-packages
  ];
  }
