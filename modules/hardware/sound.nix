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
    };
  };
}
