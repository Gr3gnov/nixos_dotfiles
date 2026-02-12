{ lib, pkgs, ... }:

let
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = "24";

  launchYandexMusic = "${lib.getExe' pkgs.gtk3 "gtk-launch"} yandex-music-web";
  launchTelegram = lib.getExe pkgs.telegram-desktop;
  launchDiscord = lib.getExe pkgs.discord;

  autostartCore = [
    "dbus-update-activation-environment --systemd --all"
    "systemctl --user start dms.service"
    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
  ];
  autostartApps = [
    launchYandexMusic
    launchTelegram
    launchDiscord
  ];
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprexpo
    ];
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
        "XCURSOR_THEME,${cursorTheme}"
        "XCURSOR_SIZE,${cursorSize}"
      ];

      exec-once = autostartCore ++ autostartApps;

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

      animations = {
        enabled = true;
        # second value it is speed. Lower = faster
        animation = [
          "windowsMove, 1, 1, default"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
