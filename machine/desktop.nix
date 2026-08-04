# Plasma as installed on the machine. Your personal Plasma settings —
# shortcuts, keyboard layout, KWin — live in user/plasma/.
{ ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    # Greeter and session are both Wayland, so there is no handoff between
    # display servers and no black screen between login and desktop. This was
    # X11 while Hyprland was in use, where NVIDIA made the Wayland greeter
    # unreliable; if the login screen misbehaves, that is the thing to revert.
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "plasma";

  # X applications still run, through XWayland. Kept on because the NVIDIA
  # driver selection in hardware/nvidia.nix reads services.xserver.videoDrivers.
  services.xserver.enable = true;

  # Clear the login VT on every transition. Without this its contents show up
  # for a moment between the greeter and the session — the console text that
  # used to be hidden behind the monitor's mode change.
  systemd.services.display-manager.serviceConfig = {
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Chromium/Electron apps run natively on Wayland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
