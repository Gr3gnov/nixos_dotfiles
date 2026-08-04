# Silent graphical boot. Plymouth covers the screen from the initrd until SDDM
# takes over, so kernel and systemd messages are never visible.
#
# This only covers boot -> greeter. The greeter -> session handoff is handled by
# the TTY settings in ./desktop.nix.
{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    theme = "breeze";
    themePackages = [ pkgs.kdePackages.breeze-plymouth ];
  };

  # Without these the messages just scroll on top of the splash.
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_level=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # The bootloader menu is deliberately left visible — it is how you roll back
  # to a previous generation when a rebuild breaks the desktop.
}
