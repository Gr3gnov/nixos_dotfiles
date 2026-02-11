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
  home.packages = with pkgs; [
    thunar
    wofi
    hyprlock
    grim
    slurp
    wl-clipboard
    screenshotRegion
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      # Physical Ctrl -> logical Super for WM hotkeys.
      "$mod" = "SUPER";

      monitor = [
        ",preferred,auto,1"
      ];

      env = [
        "NIXOS_OZONE_WL,1"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user start dms.service"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

      input = {
        kb_layout = "us,ru";
        # Physical Cmd -> logical Control for app hotkeys (Cmd+C/V/T/W/etc).
        kb_options = "grp:ctrl_space_toggle,ctrl:swap_lwin_lctl,ctrl:swap_rwin_rctl";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(3b4252)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
      };

      animations.enabled = true;

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        # Launcher:
        # - Physical Ctrl+Space -> dms spotlight (fallback to wofi).
        # - Physical Cmd+Space -> layout switch (from kb_options above).
        "$mod, SPACE, exec, dms ipc call spotlight toggle || wofi --show drun"
        "$mod, P, exec, wofi --show drun"

        "$mod, RETURN, exec, alacritty"
        "$mod, E, exec, thunar"
        "$mod, L, exec, hyprlock"

        "$mod, Q, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, F, fullscreen, 1"
        "$mod, V, togglefloating,"

        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, right, movefocus, r"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, right, movewindow, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Physical Cmd+Shift+4 screenshot to clipboard.
        "CTRL SHIFT, 4, exec, screenshot-region-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
