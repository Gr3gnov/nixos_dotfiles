{ inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./input.nix
    ./krunner.nix
    ./shortcuts.nix
  ];

  programs.plasma.enable = true;
}
