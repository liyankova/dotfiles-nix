# ~/dotfiles-nix/flake.nix
{
  description = "Konfigurasi NixOS Liyan (Tahap Awal)";

  inputs = {
    # Untuk sistem yang stabil (kernel, driver)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Untuk aplikasi terbaru (Hyprland, dll)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    # Paket stabil untuk sistem
    pkgs = import nixpkgs { inherit system; };
    # Paket unstable untuk aplikasi
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
  in
  {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; # Berguna untuk nanti

      modules = [
        ./nixos/hosts/laptop/default.nix 

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Arahkan ke file konfigurasi user Anda yang baru
          home-manager.users.liyan = import ./home/liyan.nix;
        }
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = pkgsUnstable;
            })
          ];
          nixpkgs.config.allowUnfree = true;
	  # modules = [ ./home/liyan.nix ];
        })
      ];
    };
        homeConfigurations."liyan" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsUnstable; # Home di OS lain akan pakai unstable
      modules = [ ./home/liyan.nix ];
    };
  };
}
