# How Nix itself behaves.
{ ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  # Old generations are collected daily. The bootloader keeps 15 entries
  # regardless, so rolling back after a bad rebuild stays possible.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  nixpkgs.config.allowUnfree = true;
}
