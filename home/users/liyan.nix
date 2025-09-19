{ pkgs, ... }: {
  # ... imports dan konfigurasi lain

  # Matikan pengecekan versi karena kita sengaja menggunakan setup hibrida
  home.enableNixpkgsReleaseCheck = false;

  home.stateVersion = "25.05";
  # ...
}
