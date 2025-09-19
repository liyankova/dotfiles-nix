{
  description = "Konfigurasi NixOS Liyan (Tahap Awal)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dotfiles-raw = {
      url = "github:liyankova/wallust-dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    userConfigurations = {
      liyan = {
        username = "liyan";
	homeDirectory = "/home/liyan";
	gitUsername = "liyankova";
	gitEmail = "liyannkova@gmail.com";
      };  
      newuser = {
        username = "newuser";
	homeDirectory = "/home/newuser";
	gitUsername = "newgitusername";
	gitEmail = "user@git.com";
      };
    };
    systemConfigurations = {
      laptop-hp = {
        system = "x86_64-linux";
	hostname = "nixos";
	hasNvidia = true;
      };
      server = {
        system = "aarch64-linux";
	hostname = "nixos-server";
	hasNvidia = false;
      };
    };
    # pkgs = import nixpkgs { inherit system; };
    pkgsUnstableFor = system: import inputs.nixpkgs-unstable { 
      inherit system; 
      config.allowUnfree = true; 
    };

  in
  {
    nixosConfigurations.laptop-hp = nixpkgs.lib.nixosSystem {
      # inherit system;
      system = systemConfigurations.laptop-hp.system;
      specialArgs = { 
        inherit inputs; 
	user = userConfigurations.liyan;
	host = systemConfigurations.laptop-hp;
	pkgsUnstable = pkgsUnstableFor systemConfigurations."laptop-hp".system;
      };

      modules = [
        ./nixos/hosts/laptop-hp
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.liyan = import ./home/users/liyan.nix;
        }
        # ({ config, pkgs, ... }: {
        #   nixpkgs.overlays = [
        #     (final: prev: {
        #       unstable = pkgsUnstable;
        #     })
        #   ];
        #   nixpkgs.config.allowUnfree = true;
        # })
      ];
    };
    homeConfigurations."liyan" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsUnstableFor "x86_64-linux"; 
      extraSpecialArgs = {
        user = userConfigurations.liyan;
        host = systemConfigurations.laptop-hp;
      };
      modules = [ ./home/users/liyan.nix ];
    };
  };
}
