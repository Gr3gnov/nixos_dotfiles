# Your Plasma settings. Plasma itself is installed by machine/desktop.nix.
#
# The workflow this is built around: change something in System Settings, then
# run `nix run github:nix-community/plasma-manager#rc2nix` to see the Nix for
# what you just clicked, and paste the part you want to keep into these files.
{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    # Merge on top of whatever was set in System Settings instead of wiping it.
    # Flip to true once the GUI-side tweaking has settled, so that these files
    # become the single source of truth.
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

    hotkeys.commands.launch-terminal = {
      name = "Launch Alacritty";
      key = "Meta+Return";
      command = lib.getExe pkgs.alacritty;
    };
  };

  # Started at login. Adding one here beats ticking a box in System Settings,
  # because this file survives a reinstall.
  xdg.configFile = {
    "autostart/org.telegram.desktop.desktop".source =
      "${pkgs.telegram-desktop}/share/applications/org.telegram.desktop.desktop";
    "autostart/discord.desktop".source = "${pkgs.discord}/share/applications/discord.desktop";
    "autostart/spotify.desktop".source = "${pkgs.spotify}/share/applications/spotify.desktop";
  };
}
