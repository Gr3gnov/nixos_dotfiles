{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./nix.nix
    ./fonts.nix
    ./packages.nix

    ./users.nix
    ./desktop.nix # Plasma 6 and SDDM
    ./avatar.nix # user picture on the login screen
    ./plymouth.nix # silent graphical boot
    ./gaming.nix # Steam and friends

    ./hardware/nvidia.nix
    ./hardware/sound.nix
    ./hardware/keyboard.nix
    ./hardware/logitech.nix
    ./hardware/power.nix
  ];

  # Host basics — one-liners that do not deserve a file of their own.
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
    # consoleMode is deliberately left at its default. Setting it to "max" was
    # tried to stop the monitor from re-syncing between the boot menu and the
    # session: it cost 1.7s of extra loader time and the screen still blanked,
    # because EFI cannot do 100 Hz and the kernel has to switch modes regardless.
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "192.168.10.49"
    "1.1.1.1"
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Asia/Nicosia";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker.enable = true;

  # The NixOS release this host was first installed with. Do not bump it.
  system.stateVersion = "25.11";
}
