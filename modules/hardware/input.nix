{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.my.hardware.input;
in
{
  options.my.hardware.input.enable = lib.mkEnableOption "Input tweaks (Keyd)";

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;

      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              leftmeta = "leftcontrol";
              rightmeta = "rightcontrol";

              leftcontrol = "leftmeta";

              "leftalt+rightalt" = "toggle(gaming)";
            };

            gaming = {
              "leftalt+rightalt" = "toggle(gaming)";
            };
          };
        };
      };
    };

    users.groups.uinput.members = [ "nekr0nk" ];
    users.groups.input.members = [ "nekr0nk" ];
  };
}
