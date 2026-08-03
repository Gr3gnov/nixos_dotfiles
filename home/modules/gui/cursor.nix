{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.gui.cursor;
in
{
  options.my.gui.cursor.enable = lib.mkEnableOption "Bibata cursor theme";

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
