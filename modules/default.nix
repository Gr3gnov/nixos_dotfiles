{ ... }:

{
  imports = [
    ./core/garbage-collector.nix
    ./core/fonts.nix
    ./core/packages.nix
    ./core/user.nix

    ./hardware/nvidia.nix
    ./hardware/sound.nix
    ./hardware/logitech.nix

    ./programs/plasma.nix
    ./programs/steam.nix
  ];
}
