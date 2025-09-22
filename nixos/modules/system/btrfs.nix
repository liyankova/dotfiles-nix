{ config, lib, pkgs, host, user, ... }:

(lib.mkIf (lib.elem "btrfs" host.tags) {


  # Enable periodic file system scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # By defining a config for a subvolume, the snapper service is automatically enabled.
  # The bootloader integration is also handled automatically.
  services.snapper.configs."root" = {
    SUBVOLUME = "/";
    ALLOW_USERS = [ user.username ];
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    NUMBER_CLEANUP = true;
    NUMBER_MIN_AGE = 1800;
    NUMBER_LIMIT = 25;
    NUMBER_LIMIT_IMPORTANT = 10;
    TIMELINE_LIMIT_HOURLY = 10;
    TIMELINE_LIMIT_DAILY = 10;
    TIMELINE_LIMIT_WEEKLY = 0;
    TIMELINE_LIMIT_MONTHLY = 0;
  };
})
