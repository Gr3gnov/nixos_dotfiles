{
  description = "Nekr0nk's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
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
  };

  outputs =
    {
      self,
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
            inherit
              inputs
              username
              userHome
              ;
          };
          modules = [
            ./hosts/desktop/default.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = import ./home/users/default.nix;

              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  username
                  userHome
                  ;
              };
              home-manager.backupFileExtension = "backup";
              home-manager.overwriteBackup = true;
            }
          ];
        };
      };
    };
}
