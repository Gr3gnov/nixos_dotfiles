{ pkgs, ... }:

let
  screenshotRegion = pkgs.writeShellScriptBin "screenshot-region-copy" ''
    set -eu

    area="$(${pkgs.slurp}/bin/slurp)"
    [ -n "$area" ] || exit 0

    ${pkgs.grim}/bin/grim -g "$area" - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';

  screenshotFull = pkgs.writeShellScriptBin "screenshot-full-save" ''
    set -eu

    screenshots_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
    timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
    screenshot_path="$screenshots_dir/$timestamp.png"

    mkdir -p "$screenshots_dir"
    ${pkgs.grim}/bin/grim "$screenshot_path"

    # Keep the file as the source of truth and try to mirror it to clipboard.
    ${pkgs.wl-clipboard}/bin/wl-copy < "$screenshot_path" || true
  '';
in
{
  home.packages = [
    screenshotRegion
    screenshotFull
  ];
}
