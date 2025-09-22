{
  description = "A highly structured and scalable NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # IMPORTANT: Match this branch to your nixpkgs channel
      # url = "github:nix-community/nixvim/nixos-24.05"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles-raw = {
      url = "github:liyankova/wallust-dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs:
  let
    lib = nixpkgs.lib;

    # === CONTROL PANEL ===
    userConfigurations = {
      liyan = {
        username = "liyan";
        homeDirectory = "/home/liyan";
        gitUsername = "liyankova";
        gitEmail = "liyannkova@gmail.com";
      };
    };

    systemConfigurations = {
      "laptop-hp" = {
        system = "x86_64-linux";
        hostname = "nixos";
        tags = [ "desktop" "nvidia" "gaming" "btrfs" ];
      };
      "server" = {
        system = "aarch64-linux";
        hostname = "nixos-server";
        tags = [ "server" ];
      };
    };

    # === HELPER FUNCTION ===
    mkPkgs = system: overlays: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      inherit overlays;
    };

  in
  {
    # === AUTOMATED NIXOS CONFIGURATIONS ===
    nixosConfigurations = lib.mapAttrs (hostname: hostConfig:
      let
        pkgs = mkPkgs hostConfig.system [ ]; # No overlays for system pkgs yet
        pkgsUnstable = import inputs.nixpkgs-unstable { system = hostConfig.system; config.allowUnfree = true; };
      in
      lib.nixosSystem {
        system = hostConfig.system;
        specialArgs = {
          inherit inputs;
          user = userConfigurations.liyan; # Assuming liyan is the main user for now
          host = hostConfig;
          pkgsUnstable = pkgsUnstable;
        };
        modules = [
          ./nixos/hosts/${hostname} # Automatically points to the correct host folder

          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userConfigurations.liyan.username} = import ./home/users/liyan.nix;
          }
        ];
      }
    ) systemConfigurations;

    # === AUTOMATED HOME CONFIGURATIONS ===
    homeConfigurations = lib.mapAttrs (username: userConfig:
      let
        pkgs = mkPkgs "x86_64-linux" [ (import ./overlays) ];
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          user = userConfig;
        };
        modules = [ 
	  inputs.nixvim/homeModules.nixvim
	  ./home/users/${username}.nix 
        ];

      }
    ) userConfigurations;
  };
}

# {
#   description = "Konfigurasi NixOS Liyan (Tahap Awal)";
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
#     nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs-unstable";
#     };
#     android-nixpkgs = {
#       url = "github:tadfisher/android-nixpkgs";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     dotfiles-raw = {
#       url = "github:liyankova/wallust-dotfiles";
#       flake = false;
#     };
#   };
#
#   outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
#   let
#     lib = nixpkgs.lib;
#     userConfigurations = {
#       liyan = {
#         username = "liyan";
# 	homeDirectory = "/home/liyan";
# 	gitUsername = "liyankova";
# 	gitEmail = "liyannkova@gmail.com";
#       };  
#       newuser = {
#         username = "newuser";
# 	homeDirectory = "/home/newuser";
# 	gitUsername = "newgitusername";
# 	gitEmail = "user@git.com";
#       };
#     };
#     systemConfigurations = {
#       "laptop-hp" = {
#         system = "x86_64-linux";
# 	hostname = "nixos";
# 	# hasNvidia = true;
#         tags = [ "desktop" "nvidia" "gaming" "btrfs" ];
#       };
#       server = {
#         system = "aarch64-linux";
# 	hostname = "nixos-server";
# 	# hasNvidia = false;
# 	tags = [ "server" ];
#       };
#     };
#     # pkgs = import nixpkgs { inherit system; };
#     pkgsUnstableFor = system: import inputs.nixpkgs-unstable { 
#       inherit system; 
#       config.allowUnfree = true; 
#     };
#
#   in
#   {
#     nixosConfigurations."laptop-hp" = nixpkgs.lib.nixosSystem {
#       # inherit system;
#       system = systemConfigurations."laptop-hp".system;
#       specialArgs = { 
#         inherit inputs; 
# 	user = userConfigurations.liyan;
# 	host = systemConfigurations."laptop-hp";
# 	pkgsUnstable = pkgsUnstableFor systemConfigurations."laptop-hp".system;
#       };
#
#       modules = [
# 	./nixos/hosts/laptop-hp
#         home-manager.nixosModules.home-manager
#         {
# 	  home-manager.extraSpecialArgs = { inherit inputs; };
#           home-manager.useGlobalPkgs = true;
#           home-manager.useUserPackages = true;
#           home-manager.users.liyan = import ./home/users/liyan.nix;
#         }
#
#       ];
#     };
#     homeConfigurations."liyan" = inputs.home-manager.lib.homeManagerConfiguration {
#       pkgs = pkgsUnstableFor "x86_64-linux";
#       overlays = [ (import ./overlays/default.nix { pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages."x86_64-linux"; }) ];
#       extraSpecialArgs = {
#         inherit inputs;
#         user = userConfigurations.liyan;
#         host = systemConfigurations."laptop-hp";
#         pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages."x86_64-linux";
#       };
#       modules = [ ./home/users/liyan.nix ];
#     };
#   };
# }
