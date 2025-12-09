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
in
{
  options.my.hardware.logitech.enable = lib.mkEnableOption "Logitech drivers";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.logiops ];

    environment.etc."logid.cfg".text = ''
      devices: (
        {
          name: "MX Master 4";

          smartshift: {
            on: true;
            threshold: 20;
          };
          hiresscroll: {
            hires: false;
            invert: false;
            target: false;
          };

          dpi: 1000;

          thumbwheel: {
            divert: true;
            invert: false;

            left: {
              mode: "OnInterval";
              interval: 4;
              action: {
                type: "Keypress";
                keys: ["KEY_LEFTCTRL", "KEY_LEFTBRACE"];
              };
            };

            right: {
              mode: "OnInterval";
              interval: 4;
              action: {
                type: "Keypress";
                keys: ["KEY_LEFTCTRL", "KEY_RIGHTBRACE"];
              };
            };
          };

          buttons: (
            {
              cid: 0xc3;
              action = {
                type: "Keypress";
                keys: ["KEY_LEFTCTRL"]; 
              };
            },
            {
              cid: 0x1a0;
              action = {
                type: "Keypress";
                    keys: ["KEY_LEFTMETA", "KEY_TAB"];
              };
            }
          );
        }
      );
    '';

    systemd.services.logiops = {
      enable = true;
      description = "Logitech Configuration Daemon";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.logiops}/bin/logid -c /etc/logid.cfg";
        Type = "simple";
        User = "root";
        Restart = "always";
        RestartSec = "3";
      };
    };
  };
}
