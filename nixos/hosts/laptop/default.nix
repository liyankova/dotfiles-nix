# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ../../modules/system/bootloader.nix
      ../../modules/system/core.nix
      ../../modules/system/networking.nix

      # Modul Hardware
      ../../modules/hardware/nvidia.nix
    ];
nixpkgs.config.nvidia.acceptLicense = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
   enable = true;
   efiSupport = true;
   # version = 2;
   device = "nodev";
   useOSProber = false;
  };
  boot.loader.grub.extraEntries = ''
    menuentry "Debian" {
      search --fs-uuid --set=root 6ED1-C749
      chainloader /EFI/debian/shimx64.efi
  }
  '';
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.useDHCP = lib.mkDefault true;
  # Set your time zone.
  # time.timeZone = "Asia/Jakarta";
  #
  # # Configure network proxy if necessary
  # # networking.proxy.default = "http://user:password@proxy:port/";
  # # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #
  # # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # #   useXkbConfig = true; # use xkb.options in tty.
  # };
# hardware.nvidia = {
#   # Gunakan driver legacy_470, yang paling umum untuk Maxwell/MX130
#   # Ini adalah kunci utamanya.
#   # package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
#
#   # Gunakan modul kernel proprietary (bukan open-source)
#   open = false;
#
#   # Aktifkan modesetting. Penting untuk Wayland/Hyprland nanti.
#   modesetting.enable = true;
# };

  services.libinput.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      };
    defaultSession = "hyprland";
  };

  # programs.git = {
  #   enable = true; 
  #   userName = "liyan";
  #   userEmail = "liyannkova@gmail.com";
  #   };

  # Enable the X11 windowing system.


  services.xserver.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];

  
# boot.kernelPackages = pkgs.linuxPackages_lts;
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.liyan = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };
#   home-manager.users.liyan = {
#     # Opsi dasar Home Manager
#     home.username = "liyan";
#     home.homeDirectory = "/home/liyan";
#     home.stateVersion = "25.05";
#     programs.home-manager.enable = true;
#
#     # Di sinilah keajaibannya terjadi.
#     # Ini memberitahu Nix untuk men-symlink file/folder dari dotfiles-raw Anda.
#     xdg.configFile = {
#       # Contoh 1: Men-symlink seluruh direktori hyprland
#       "hyprland" = {
#         source = /home/liyan/dotfiles-raw/hyprland; # Arahkan ke folder sumber
#         recursive = true; # Pastikan semua isinya ikut di-symlink
#       };
#
#       # Contoh 2: Men-symlink seluruh direktori waybar
#       "waybar" = {
#         source = /home/liyan/dotfiles-raw/waybar;
#         recursive = true;
#       };
#
#       # Contoh 3: Men-symlink seluruh direktori kitty
#       "kitty" = {
#         source = /home/liyan/dotfiles-raw/kitty;
#         recursive = true;
#       };
# };     
# };
  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim git curl neovim tmux # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget btrfs-progs dmenu-wayland firefox stow
  #   home-manager zsh gh
  #   # unstable.hyprland unstable.waybar unstable.kitty
  # ];

  programs = {
    hyprland = {
      enable = true;
      # wayland.enable = true;
      xwayland.enable = true;
      # portalPackages = pkgs.xdg-desktop-portal-hyprland;
    };
    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    mtr.enable = true;
	#    xdg.portal = {
	#      enable = true;
	#      wlr.enable = false;
	#      extraPortals = with pkgs; [
	#        xdg-desktop-portal-gtk
	# ];
	# };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland; wcb";
    SDL_VIDEODRIVER = "wayland";
    };
    

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

