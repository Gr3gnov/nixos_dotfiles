{ lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
    ];
    location = "top";
    yoffset = 24;
    extraConfig = {
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "apps";
    };
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "󰌾  Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "󰗽  Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "󰤄  Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "󰜉  Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "󰐥  Shutdown";
        keybind = "s";
      }
    ];
    style = ''
      window {
        background: alpha(@theme_bg_color, 0.92);
      }

      button {
        color: @theme_fg_color;
        background: alpha(@theme_base_color, 0.86);
        border: 2px solid alpha(@theme_fg_color, 0.1);
        border-radius: 12px;
        margin: 10px;
        font-family: "FiraCode Nerd Font", "FiraCode Nerd Font Mono", "Noto Sans";
        font-size: 15px;
      }

      button:focus, button:hover {
        color: @theme_selected_fg_color;
        background: alpha(@theme_selected_bg_color, 0.42);
      }
    '';
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 8;

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "mpris"
          "clock"
          "custom/weather"
        ];
        modules-right = [
          "tray"
          "hyprland/language"
          "custom/clipboard"
          "memory"
          "bluetooth"
          "pulseaudio"
          "custom/notifications"
          "custom/power"
        ];

        "custom/launcher" = {
          format = "󰣇";
          on-click = "rofi -show drun";
          tooltip = true;
          tooltip-format = "Launcher";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };

        "hyprland/window" = {
          max-length = 70;
          separate-outputs = true;
        };

        "mpris" = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} paused";
          max-length = 42;
          player-icons = {
            default = "music";
          };
          status-icons = {
            paused = "pause";
            playing = "play";
            stopped = "stop";
          };
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
          };
        };

        "custom/weather" = {
          exec = "${lib.getExe pkgs.wttrbar}";
          return-type = "json";
          interval = 1800;
          format = "{}";
        };

        "tray" = {
          spacing = 10;
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "EN";
          format-ru = "RU";
        };

        "custom/clipboard" = {
          exec = "echo 󰅌";
          interval = "once";
          on-click = "cliphist list | rofi -dmenu -i -p clipboard | cliphist decode | wl-copy";
          tooltip = true;
          tooltip-format = "Clipboard history";
        };

        "memory" = {
          interval = 5;
          format = "mem {}%";
          tooltip = true;
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "󰂱";
          tooltip-format = "{status}";
          on-click = "blueman-manager";
          on-click-right = "blueman-manager";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "custom/notifications" = {
          tooltip = true;
          tooltip-format = "Notifications / DND";
          format = "{icon}";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          return-type = "json";
          exec-if = "command -v swaync-client >/dev/null";
          exec = "swaync-client -swb";
          on-click = "swaync-client -d -sw";
          on-click-right = "swaync-client -op -sw";
          on-click-middle = "swaync-client -C -sw";
          escape = true;
        };

        "custom/power" = {
          exec = "echo ⏻";
          interval = "once";
          on-click = "wlogout";
          tooltip = true;
          tooltip-format = "Power menu";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-size: 12px;
      }

      window#waybar {
        color: @theme_fg_color;
        background: alpha(@theme_bg_color, 0.9);
        border-bottom: 1px solid alpha(@theme_fg_color, 0.08);
      }

      #custom-launcher,
      #workspaces,
      #window,
      #mpris,
      #clock,
      #custom-weather,
      #tray,
      #language,
      #custom-clipboard,
      #memory,
      #bluetooth,
      #pulseaudio,
      #custom-notifications,
      #custom-power {
        margin: 5px 0;
        padding: 0 10px;
        min-height: 24px;
        border-radius: 10px;
        background: alpha(@theme_base_color, 0.82);
      }

      #custom-launcher,
      #custom-power {
        font-family: "FiraCode Nerd Font", "FiraCode Nerd Font Mono", "Noto Sans";
        font-size: 16px;
        font-weight: 700;
        padding: 0 12px;
      }

      #custom-clipboard,
      #bluetooth,
      #custom-notifications {
        font-family: "FiraCode Nerd Font", "FiraCode Nerd Font Mono", "Noto Sans";
        font-size: 15px;
        min-width: 28px;
      }

      #workspaces button {
        color: @theme_fg_color;
        margin: 0 2px;
        padding: 0 8px;
        border-radius: 8px;
        background: transparent;
      }

      #workspaces button.active {
        color: @theme_selected_fg_color;
        background: alpha(@theme_selected_bg_color, 0.45);
      }

      #workspaces button.urgent {
        color: @warning_color;
      }
    '';
  };

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      timeout = 5;
      fit-to-screen = true;

      control-center-width = 420;
      control-center-height = 740;
      notification-window-width = 420;
      control-center-margin-top = 12;
      control-center-margin-right = 12;
      control-center-margin-bottom = 12;
      control-center-margin-left = 12;

      widgets = [
        "title"
        "dnd"
        "buttons-grid"
        "volume"
        "backlight"
        "mpris"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Quick Settings";
          clear-all-button = true;
          button-text = "Clear";
        };

        dnd = {
          text = "Do Not Disturb";
        };

        mpris = {
          image-size = 72;
          image-radius = 8;
        };

        volume = {
          label = "Volume";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = true;
        };

        backlight = {
          label = "Brightness";
        };

        "buttons-grid" = {
          buttons-per-row = 4;
          actions = [
            {
              label = "󰤨 Wi-Fi";
              command = "nm-connection-editor";
            }
            {
              label = "󰂯 BT";
              command = "blueman-manager";
            }
            {
              label = "󰕾 Audio";
              command = "pavucontrol";
            }
            {
              label = "⏻ Power";
              command = "wlogout";
            }
          ];
        };
      };
    };
    style = ''
      .control-center {
        border-radius: 14px;
        background: alpha(@theme_bg_color, 0.94);
      }

      .notification {
        border-radius: 12px;
        background: alpha(@theme_base_color, 0.86);
      }

      .widget-title {
        font-weight: 600;
      }
    '';
  };
}
