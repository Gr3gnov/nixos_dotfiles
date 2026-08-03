# Desktop, not a laptop: pin the CPU to the performance profile at boot.
{ config, lib, ... }:

{
  services.power-profiles-daemon.enable = lib.mkDefault true;

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
}
