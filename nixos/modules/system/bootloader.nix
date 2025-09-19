{ config, pkgs, ... }:
{
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

}
