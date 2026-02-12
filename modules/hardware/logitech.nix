/*
  CID   |      Name
  -------------------------
  0x52  | Middle button
  0xc4  | Shift wheel mode
  0x56  | Forward
  0x53  | Back
  0xc3  | Gestures
    -    | thumbwheel
  0x1a0 | Actions Ring
  0xd7  | ????
*/
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.my.hardware.logitech;
  logidConfigPath = "/etc/logid.cfg";
in
{
  options.my.hardware.logitech.enable = lib.mkEnableOption "Logitech drivers";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.logiops ];

    # Keep button/action mapping in a dedicated file for easier editing.
    environment.etc."logid.cfg".source = ./logid.cfg;

    systemd.services.logiops = {
      enable = true;
      description = "Logitech Configuration Daemon";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.logiops}/bin/logid -c ${logidConfigPath}";
        Type = "simple";
        User = "root";
        Restart = "always";
        RestartSec = "3";
      };
    };
  };
}
