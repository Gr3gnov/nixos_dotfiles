{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.plasma;
in
{
  options.my.programs.plasma.enable = lib.mkEnableOption "KDE Plasma 6 desktop";

  config = lib.mkIf cfg.enable {
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
  };
}
