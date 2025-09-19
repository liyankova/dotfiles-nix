{ pkgs, ... }: 
{
  # Impor modul-modul Home Manager di sini
  imports = [
    # ../modules/cli/zsh.nix # (Contoh, akan kita buat nanti)
  ];

  # --- Pengaturan Dasar ---
  home.username = "liyan";
  home.homeDirectory = "/home/liyan";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # --- Perbaikan Warning Versi ---
  # Matikan pengecekan versi karena kita sengaja pakai hybrid
  home.enableNixpkgsReleaseCheck = false;

  # --- Paket-paket Awal ---
  home.packages = with pkgs; [
    htop
    fastfetch
    neofetch
  ];
}
