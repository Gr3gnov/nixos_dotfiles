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

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    input = import ./input.nix;
    kwin = import ./kwin.nix;
    shortcuts = import ./shortcuts.nix;

    hotkeys.commands.launch-terminal = {
      name = "Launch Alacritty";
      key = "Meta+Return";
      command = lib.getExe pkgs.alacritty;
    };
  };

}
