{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.steam;
in
{
  options.my.programs.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {

    hardware.graphics.enable32Bit = lib.mkDefault true;

    programs.steam = {
      enable = true;

      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;

      gamescopeSession.enable = true;
    };

    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      goverlay
      protonup-qt
      nvtopPackages.full
      vulkan-tools
      mesa-demos
    ];
  };
}
