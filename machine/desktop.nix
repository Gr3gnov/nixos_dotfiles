# Plasma as installed on the machine. Your personal Plasma settings —
# shortcuts, keyboard layout, KWin — live in user/plasma/.
{ ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    # The greeter stays on X11: more stable on NVIDIA and avoids visible
    # black-frame artifacts during handoff. The session itself is Wayland.
    wayland.enable = false;
  };
  services.displayManager.defaultSession = "plasma";

  # Required when SDDM runs with DisplayServer=x11.
  services.xserver.enable = true;

  # Chromium/Electron apps run natively on Wayland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
