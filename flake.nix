# ~/dotfiles-nix/flake.nix
{
  description = "Konfigurasi NixOS Liyan (Tahap Awal)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
  in
  {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./nixos/hosts/laptop/default.nix 
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.liyan = import ./home/liyan.nix;
        }
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = pkgsUnstable;
            })
          ];
          nixpkgs.config.allowUnfree = true;
        })
      ];
    };
        homeConfigurations."liyan" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsUnstable; 
      modules = [ ./home/users/liyan.nix ];
    };
  };
}
