{ pkgs, ... }:

let
  screenshotRegion = pkgs.writeShellScriptBin "screenshot-region-copy" ''
    set -eu

    area="$(${pkgs.slurp}/bin/slurp)"
    [ -n "$area" ] || exit 0

    ${pkgs.grim}/bin/grim -g "$area" - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
in
{
  home.packages = [
    screenshotRegion
  ];
}
