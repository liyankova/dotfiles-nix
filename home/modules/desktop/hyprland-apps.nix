{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    dmenu-wayland
    firefox
    rofi
  ];

  programs.waybar = {
    enable = true;
  };
  {
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

}
