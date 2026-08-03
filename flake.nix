{
  description = "Nekr0nk's NixOS Configuration";

  inputs = {
    # Stable channel on purpose: this machine should keep working across
    # updates rather than track the newest packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code-nix = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "nekr0nk";
      userHome = "/home/${username}";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit username userHome;
          };
          modules = [
            # Everything that needs root and applies to the whole machine.
            ./machine

            { nixpkgs.overlays = [ inputs.claude-code-nix.overlays.default ]; }

            # Everything that is yours and runs as you. Home-manager is a NixOS
            # module here, so one rebuild applies both halves.
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = import ./user;

              home-manager.extraSpecialArgs = {
                inherit inputs username userHome;
              };
              home-manager.backupFileExtension = "backup";
              home-manager.overwriteBackup = true;
            }
          ];
        };
      };
    };
}
