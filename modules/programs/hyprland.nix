{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.hyprland;
in
{
  options.my.programs.hyprland.enable = lib.mkEnableOption "Hyprland with greetd, ReGreet, and DankMaterialShell";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Packaged in nixpkgs from AvengeMedia/DankMaterialShell.
    programs.dms-shell.enable = true;

    services.greetd.enable = true;
    services.displayManager.defaultSession = "hyprland";

    programs.regreet.enable = true;

    programs.thunar.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    security.polkit.enable = true;

    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
