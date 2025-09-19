# nixos/modules/desktop/hyprland.nix
{ pkgs, ... }: 
{


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
    systemd.services.hypr-shebang = {
    wantedBy = [ "multi-user.target" ];
    after    = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "liyan";
      ExecStart = pkgs.writeScript "fix-shebang" ''
        #!${pkgs.bash}/bin/bash
        find /home/liyan/.config/hypr/scripts -type f -exec \
          sed -i '1s|#!/bin/bash|#!/usr/bin/env bash|' {} +
        find /home/liyan/.config/hypr/UserScripts -type f -exec \
          sed -i '1s|#!/bin/bash|#!/usr/bin/env bash|' {} +
      '';
    };
  };
}
