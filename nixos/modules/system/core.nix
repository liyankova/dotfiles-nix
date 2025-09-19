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
    description = user.gitUsername;
    home = user.homeDirectory;
    extraGroups = [ "wheel" "games" "video" "adbusers" "kvm" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    git curl vim jq
    btrfs-progs
    home-manager
    catppuccin-sddm
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

}
