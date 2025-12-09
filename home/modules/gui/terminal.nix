{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.gui.terminal;
in
{
  options.my.gui.terminal.enable = lib.mkEnableOption "Alacritty Terminal";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      package = (
        pkgs.alacritty.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
          postInstall = (old.postInstall or "") + ''
            wrapProgram $out/bin/alacritty --set LIBGL_ALWAYS_SOFTWARE 1
          '';
        })
      );

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
          {
            key = "C";
            mods = "Control";
            action = "Copy";
          }
          {
            key = "V";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "C";
            mods = "Super";
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
            mods = "Command";
            chars = "\\u0005";
          }
          {
            key = "Left";
            mods = "Command";
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
