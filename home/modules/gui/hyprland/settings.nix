{ pkgs, ... }:

{
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
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,24"
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
    };
  };
}
