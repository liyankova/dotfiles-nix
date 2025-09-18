# ~/dotfiles-nix/home/liyan.nix
{ pkgs, ... }:
{
  imports = [
    # Import modul yang akan kita buat untuk mengelola symlink
    # ../modules/home/dotfiles-links.nix
  ];

  home.username = "liyan";
  home.homeDirectory = "/home/liyan";

  # Pindahkan paket-paket user dari nixos.nix ke sini
  home.packages = with pkgs; [
    hyprland
    waybar
    kitty
    # tambahkan paket lain yang spesifik untuk user di sini
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
