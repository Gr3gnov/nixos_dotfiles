{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  my.hardware.nvidia.enable = true;
  my.hardware.sound.enable = true;
  my.hardware.logitech.enable = true;
  my.programs.plasma.enable = true;
  my.core.gc.enable = true;
  my.core.essentials.enable = true;
  my.core.user.enable = true;
  my.programs.steam.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
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
  nixpkgs.config.allowUnfree = true;
  services.printing.enable = false;
  documentation.nixos.enable = false;
  system.stateVersion = "25.11";

  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };
}
