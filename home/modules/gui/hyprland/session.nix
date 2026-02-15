{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(230, 230, 230)";
          font_size = 64;
          position = "0, 130";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date +%Y-%m-%d";
          color = "rgb(200, 200, 200)";
          font_size = 18;
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "320, 54";
          position = "0, -80";
          outline_thickness = 2;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "Password";
          hide_input = false;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
