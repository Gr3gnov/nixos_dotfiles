{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Launcher:
      # - Physical Ctrl+Space -> dms spotlight.
      # - Physical Cmd+Space -> layout switch (from kb_options above).
      "$mod, SPACE, exec, dms ipc call spotlight toggle"
      "$mod, TAB, exec, hyprctl dispatch hyprexpo:expo toggle"

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
      "$mod, period, workspace, m+1"
      "$mod, comma, workspace, m-1"

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
}
