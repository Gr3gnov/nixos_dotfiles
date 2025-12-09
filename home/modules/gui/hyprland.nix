{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.gui.hyprland;
in
{
  options.my.gui.hyprland.enable = lib.mkEnableOption "Hyprland User Config";
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings = {

        # ===MONITORS===
        monitor = [
          ",preferred,auto,1"
        ];

        # ===VARIABLES===
        "$terminal" = "alacritty";
        "$mainMod" = "SUPER";
        "$menu" = "dms ipc call spotlight toggle";

        # ===ENV===
        env = [
          "WINIT_UNIX_BACKEND,x11"
          "XDG_SESSION_TYPE,wayland"

        ];

        # ===AUTOSTART===
        exec-once = [
          "dms run"
        ];

        # ===INPUT===
        input = {
          kb_layout = "us,ru";
          follow_mouse = 1;
          scroll_factor = 0.9;
          sensitivity = 0;
          natural_scroll = false;
        };

        # ===GENERAL===
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        # ===DECORATION===
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        # ===ANIMATIONS===
        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];
          animation = [
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.49,  linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  almostLinear, fade"
            "workspacesIn,  1,     1.21,  almostLinear, fade"
            "workspacesOut, 1,     1.94,  almostLinear, fade"
          ];
        };

        # ===LAYOUTS===
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
        };

        # ===KEYBINDINGS===
        bind = [
          "CONTROL, Return, exec, $terminal"
          "CONTROL, Q, killactive,"
          "CONTROL, Space, exec, hyprctl switchxkblayout all next"

          "$mainMod, Space, exec, $menu"
          "$mainMod, M, exit,"
          "$mainMod, V, togglefloating,"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          # Focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$CONTROL SHIFT, 3, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$CONTROL SHIFT, 4, exec, grim -g \"$(slurp)\" - | swappy -f -"

          # Switch workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod, bracketleft, workspace, r-1"
          "$mainMod, bracketright, workspace, r+1"

          # Move window to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Move window on screen
          "$mainMod ALT, right, movewindow, r"
          "$mainMod ALT, left, movewindow, l"
          "$mainMod ALT, up, movewindow, u"
          "$mainMod ALT, down, movewindow, d"

          # Resize window
          "$mainMod SHIFT, right, resizeactive, 60 0"
          "$mainMod SHIFT, left, resizeactive, -60 0"
          "$mainMod SHIFT, up, resizeactive, 0 -60"
          "$mainMod SHIFT, down, resizeactive, 0 60"
        ];

        # Mouse bindings
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Media keys
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        # ===WINDOW RULES===
        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
    };
    xdg.configFile."swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshots
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png

      early_exit=true

      line_size=5
      text_size=20
      text_font=sans-serif
      paint_mode=brush
    '';
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      swappy
    ];
  };
}
