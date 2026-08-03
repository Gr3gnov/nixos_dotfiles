# Cursor for GTK and X11 apps. Plasma keeps its own copy of this setting —
# see the workspace block in ./plasma/default.nix.
{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
