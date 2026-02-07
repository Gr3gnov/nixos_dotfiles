{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.my.hardware.sound;
in
{
  options.my.hardware.sound.enable = lib.mkEnableOption "Sound (Pipewire)";
  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig."10-bluetooth-a2dp-only" = {
          # Avoid HFP/HSP profile negotiation issues that can block connection on some headsets.
          "monitor.bluez.properties" = {
            "bluez5.hfphsp-backend" = "native";
            "bluez5.roles" = [
              "a2dp_sink"
              "a2dp_source"
            ];
          };
        };
      };
    };
  };
}
