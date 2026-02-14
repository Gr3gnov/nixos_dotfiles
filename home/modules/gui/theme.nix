{ lib, pkgs, ... }:

{
  options.qt = {
    qt5ctSettings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = "Compatibility shim for Stylix on this Home Manager revision.";
    };

    qt6ctSettings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = "Compatibility shim for Stylix on this Home Manager revision.";
    };
  };

  config = {
    stylix = {
      enable = true;
      overlays.enable = false;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      targets = {
        qt.enable = lib.mkForce false;
        alacritty.enable = lib.mkForce false;
        hyprland.enable = lib.mkForce false;
        hyprlock.enable = lib.mkForce false;
        zen-browser.enable = lib.mkForce false;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = lib.mkForce "adwaita";
      style.name = lib.mkForce "adwaita-dark";
    };

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "Papirus-Dark";
      };
    };

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
