{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.my.core.essentials;
in
{
  options.my.core.essentials.enable = lib.mkEnableOption "Essential packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      ripgrep
    ];
  };
}
