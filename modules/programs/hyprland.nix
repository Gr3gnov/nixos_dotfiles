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
  options.my.programs.hyprland.enable = lib.mkEnableOption "Hyprland System Config";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [

    ];

    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      excludePackages = [ pkgs.xterm ];
    };

    environment.sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };
}
