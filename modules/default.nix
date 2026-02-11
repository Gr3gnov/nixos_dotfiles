{ ... }:

{
  imports = [
    ./core/garbage-collector.nix
    ./core/fonts.nix
    ./core/nix.nix
    ./core/packages.nix
    ./core/user.nix

    ./hardware/nvidia.nix
    ./hardware/sound.nix
    ./hardware/logitech.nix

    ./programs/hyprland.nix
    ./programs/steam.nix
  ];
}
