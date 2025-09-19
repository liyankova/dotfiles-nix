# nixos/modules/system/btrfs.nix
{ pkgs, ... }:

{
  # Enable periodic file system scrubbing to detect and repair data corruption.
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # Enable snapper for automatic snapshots
  services.snapper = {
    enable = true;
    configs."root" = {
      SUBVOLUME = "/";
      ALLOW_USERS = [ "liyan" ];
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
  };
}
