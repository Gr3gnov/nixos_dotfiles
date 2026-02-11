{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  my.hardware.nvidia.enable = true;
  my.hardware.sound.enable = true;
  my.hardware.logitech.enable = true;
  my.programs.hyprland.enable = true;
  my.core.gc.enable = true;
  my.core.essentials.enable = true;
  my.core.fonts.enable = true;
  my.core.nix.enable = true;
  my.core.user.enable = true;
  my.programs.steam.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Asia/Nicosia";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker.enable = true;
  system.stateVersion = "25.11";

}
