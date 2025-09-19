{ config, pkgs, lib, user, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Jakarta"; 
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  programs.zsh.enable = true;
  users.users.${user.username} = {
    isNormalUser = true;
    description = "Liyan";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };
  environment.systemPackages = with pkgs; [
    git curl vim jq
    btrfs-progs
    home-manager
  ];
}
