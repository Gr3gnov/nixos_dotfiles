{
  config,
  lib,
  ...
}:
let
  cfg = config.my.core.gc;
in
{
  options.my.core.gc.enable = lib.mkEnableOption "Garbage Collector";

  config = lib.mkIf cfg.enable {
    nix = {
      settings.auto-optimise-store = true;

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 3d";
      };
    };
  };
}
