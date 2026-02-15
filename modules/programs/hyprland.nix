{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.hyprland;
  sddmTheme = pkgs."elegant-sddm";
  sddmThemeQtDeps =
    (sddmTheme.propagatedUserEnvPkgs or [ ])
    ++ (sddmTheme.propagatedBuildInputs or [ ]);
in
{
  options.my.programs.hyprland.enable = lib.mkEnableOption "Hyprland desktop stack";

  config = lib.mkIf cfg.enable {
    # Required when SDDM runs with DisplayServer=x11.
    services.xserver.enable = true;

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      # X11 is currently more stable for SDDM on NVIDIA and avoids visible
      # black-frame artifacts during handoff to the user session.
      wayland.enable = false;
      theme = "Elegant";
      extraPackages = sddmThemeQtDeps;
    };
    services.displayManager.defaultSession = "hyprland";

    # Make the selected SDDM theme available in /run/current-system/sw.
    environment.systemPackages = [ sddmTheme ];

    # Clear login TTY contents on transitions to avoid one-frame visual leaks.
    systemd.services.display-manager.serviceConfig = {
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    programs.thunar.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    security.polkit.enable = true;
    security.pam.services.hyprlock = { };

    xdg.portal = {
      enable = lib.mkDefault true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
