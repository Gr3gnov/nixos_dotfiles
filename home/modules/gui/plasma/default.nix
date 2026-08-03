{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.gui.plasma;
in
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  options.my.gui.plasma.enable = lib.mkEnableOption "Declarative KDE Plasma configuration";

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;

      # Merge on top of whatever was set in System Settings instead of wiping
      # it. Flip to true once the GUI-side tweaking has settled, so that the
      # config here becomes the single source of truth.
      overrideConfig = false;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
      };

      input = import ./input.nix;
      kwin = import ./kwin.nix;
      shortcuts = import ./shortcuts.nix;

      hotkeys.commands = {
        launch-terminal = {
          name = "Launch Alacritty";
          key = "Meta+Return";
          command = lib.getExe pkgs.alacritty;
        };
      };
    };

    # Apps that used to be started by Hyprland's exec-once.
    xdg.configFile = {
      "autostart/org.telegram.desktop.desktop".source =
        "${pkgs.telegram-desktop}/share/applications/org.telegram.desktop.desktop";
      "autostart/discord.desktop".source = "${pkgs.discord}/share/applications/discord.desktop";
      "autostart/spotify.desktop".source = "${pkgs.spotify}/share/applications/spotify.desktop";
    };
  };
}
