{
  config,
  lib,
  ...
}:

let
  cfg = config.my.hardware.power;
in
{
  options.my.hardware.power.enable = lib.mkEnableOption "Force a fixed power profile";

  config = lib.mkIf cfg.enable {
    systemd.services.force-performance-profile = {
      description = "Force power profile to performance";
      wantedBy = [ "multi-user.target" ];
      requires = [ "power-profiles-daemon.service" ];
      after = [
        "dbus.service"
        "power-profiles-daemon.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe' config.services.power-profiles-daemon.package "powerprofilesctl"} set performance";
      };
    };
  };
}
