# ~/dotfiles-nix/modules/home/dotfiles-links.nix
{ pkgs, ... }:
{
  # Opsi xdg.configFile akan membuat symlink di dalam ~/.config/
  xdg.configFile = {
    # Membuat symlink: ~/.config/hyprland -> ~/dotfiles-raw/hyprland
    "hypr" = { # Nama target di .config adalah 'hypr', bukan 'hyprland'
      source = ../../../dotfiles-raw/hypr/.config/hypr; # Path yang benar dan lebih dalam
      recursive = true;
    };

    # Asumsi struktur yang sama untuk kitty
    # Target: ~/.config/kitty
    # Sumber: ~/dotfiles-raw/kitty/.config/kitty
    "kitty" = {
      source = ../../../dotfiles-raw/kitty/.config/kitty; # Sesuaikan path ini
      recursive = true;
    };
    # };

    # Tambahkan entri lain untuk waybar, rofi, dll. di sini
    # "waybar" = { source = ../../../dotfiles-raw/waybar; recursive = true; };
  };
}
