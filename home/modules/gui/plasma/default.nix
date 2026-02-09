{ inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./input.nix
    ./krunner.nix
    ./screen-edges.nix
    ./spectacle.nix
    ./shortcuts.nix
  ];

  programs.plasma.enable = true;
}
