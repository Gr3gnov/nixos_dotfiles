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

    screenshots_dir="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
    timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
    screenshot_path="$screenshots_dir/$timestamp.png"

    mkdir -p "$screenshots_dir"
    ${pkgs.grim}/bin/grim "$screenshot_path"

    # Keep the file as the source of truth and try to mirror it to clipboard.
    ${pkgs.wl-clipboard}/bin/wl-copy < "$screenshot_path" || true
  '';

  nightFilter = pkgs.writeShellScriptBin "night-filter" ''
    set -eu

    hyprsunset="${pkgs.hyprsunset}/bin/hyprsunset"
    timeout_bin="${pkgs.coreutils}/bin/timeout"
    awk_bin="${pkgs.gawk}/bin/awk"
    socat_bin="${pkgs.socat}/bin/socat"
    pkill_bin="${pkgs.procps}/bin/pkill"
    step=5
    min_level=0
    max_level=100
    min_temp=2500
    max_temp=6500

    his="''${HYPRLAND_INSTANCE_SIGNATURE:-}"
    runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    if [ -n "$his" ]; then
      socket_path="$runtime_dir/hypr/$his/.hyprsunset.sock"
    else
      socket_path="$runtime_dir/hypr/.hyprsunset.sock"
    fi

    ipc_cmd() {
      printf '%s' "$1" | "$timeout_bin" 0.5s "$socat_bin" - UNIX-CONNECT:"$socket_path" 2>/dev/null || true
    }

    ensure_hyprsunset() {
      # Never keep both managers active.
      "$pkill_bin" -x gammastep >/dev/null 2>&1 || true

      cur="$(ipc_cmd temperature)"
      case "$cur" in
        [0-9]*)
          return 0
          ;;
      esac

      "$pkill_bin" -x hyprsunset >/dev/null 2>&1 || true
      "$hyprsunset" -i >/dev/null 2>&1 &

      i=0
      while [ "$i" -lt 30 ]; do
        cur="$(ipc_cmd temperature)"
        case "$cur" in
          [0-9]*)
            return 0
            ;;
        esac
        sleep 0.05
        i=$((i + 1))
      done

      return 1
    }

    ensure_hyprsunset || true

    current_temp_raw="$(ipc_cmd temperature)"
    current_temp="$("$awk_bin" -v t="$current_temp_raw" 'BEGIN {
      if (t ~ /^[0-9]+$/) {
        if (t < 1000) t = 1000;
        if (t > 20000) t = 20000;
        print t;
      } else {
        print 6500;
      }
    }')"
    temp_level="$("$awk_bin" -v t="$current_temp" -v lo="$min_temp" -v hi="$max_temp" 'BEGIN {
      if (t ~ /^[0-9]+$/) {
        x = (hi - t) * 100 / (hi - lo);
        if (x < 0) x = 0;
        if (x > 100) x = 100;
        printf "%d\n", int(x + 0.5);
      } else {
        print 0;
      }
    }')"

    action="''${1:-up}"
    level="$temp_level"
    case "$action" in
      up)
        level=$((level + step))
        ;;
      down)
        level=$((level - step))
        ;;
      set)
        requested="''${2:-}"
        case "$requested" in
          ""|*[!0-9]*)
            exit 2
            ;;
        esac
        level="$requested"
        ;;
      apply)
        ;;
      *)
        exit 2
        ;;
    esac

    if [ "$level" -lt "$min_level" ]; then
      level="$min_level"
    elif [ "$level" -gt "$max_level" ]; then
      level="$max_level"
    fi

    if [ "$level" -gt 0 ]; then
      temp=$((max_temp - (level * (max_temp - min_temp) / max_level)))
      ipc_cmd "temperature $temp" >/dev/null
    else
      ipc_cmd identity >/dev/null
    fi

    # Use Caelestia brightness as an on-screen proxy (0-100%).
    "$timeout_bin" 1.2s caelestia shell brightness set "$level%" >/dev/null 2>&1 || true
  '';
in
{
  home.packages = [
    screenshotRegion
    screenshotFull
    nightFilter
  ];
}
