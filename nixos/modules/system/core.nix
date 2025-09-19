{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Jakarta"; 
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  programs.zsh.enable = true;
  users.users.liyan = {
    isNormalUser = true;
    description = "Liyan";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };
  environment.systemPackages = with pkgs; [
    git curl vim
    btrfs-progs
    home-manager
  ];
}
