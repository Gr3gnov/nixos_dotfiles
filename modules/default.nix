{ config, pkgs, ... }:

{
  imports = [
    ./core/garbage-collector.nix
    ./core/packages.nix
    ./core/user.nix

    ./hardware/nvidia.nix
    ./hardware/sound.nix
    ./hardware/input.nix
    ./hardware/logitech.nix

    ./programs/hyprland.nix
    ./programs/steam.nix

  ];
}
