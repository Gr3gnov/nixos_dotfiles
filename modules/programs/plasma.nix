{
  config,
  lib,
  ...
}:
let
  cfg = config.my.programs.plasma;
in
{
  options.my.programs.plasma.enable = lib.mkEnableOption "KDE Plasma 6";

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    services.displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    services.xserver = {
      enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
