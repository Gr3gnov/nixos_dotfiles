{
  config,
  lib,
  ...
}:

let
  cfg = config.my.core.nix;
in
{
  options.my.core.nix.enable = lib.mkEnableOption "Base Nix settings";

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
