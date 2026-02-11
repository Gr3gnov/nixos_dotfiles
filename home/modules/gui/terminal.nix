{
  config,
  lib,
  ...
}:

let
  cfg = config.my.gui.terminal;
in
{
  options.my.gui.terminal.enable = lib.mkEnableOption "Alacritty terminal";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        env.TERM = "xterm-256color";

        window = {
          dimensions = {
            lines = 35;
            columns = 160;
          };
          padding = {
            x = 20;
            y = 20;
          };
          opacity = 0.75;
          blur = true;
        };

        selection.save_to_clipboard = true;

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          normal = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          size = 15;
        };

        cursor.style.shape = "Beam";

        keyboard.bindings = [
          # With the system keyboard remap:
          # - Physical Cmd/Win uses logical Control bindings.
          # - Physical Control uses logical Super bindings.
          {
            key = "C";
            mods = "Control";
            action = "Copy";
          }
          {
            key = "Q";
            mods = "Control";
            action = "Quit";
          }
          {
            key = "V";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "C";
            mods = "Super";
            # Keep SIGINT on physical Control+C.
            chars = "\\u0003";
          }
          # move-to by words
          {
            key = "Right";
            mods = "Alt";
            chars = "\\u001BF";
          }
          {
            key = "Left";
            mods = "Alt";
            chars = "\\u001BB";
          }
          # move-to beginning/end of line
          {
            key = "Right";
            mods = "Super";
            chars = "\\u0005";
          }
          {
            key = "Left";
            mods = "Super";
            chars = "\\u0001";
          }
          # remove all text
          {
            key = "Back";
            mods = "Control";
            chars = "\\u0015";
          }
        ];
      };
    };
  };
}
