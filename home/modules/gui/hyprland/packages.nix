{
  lib,
  pkgs,
  ...
}:

let
  clipboardHistoryPicker = pkgs.writeShellScriptBin "clipboard-history-picker" ''
    set -eu

    # cliphist-fuzzel-img expects common tools in PATH.
    export PATH="${lib.makeBinPath [
      pkgs.cliphist
      pkgs.fuzzel
      pkgs.wl-clipboard
      pkgs.gawk
      pkgs.findutils
      pkgs.coreutils
      pkgs.gnugrep
    ]}"

    exec ${pkgs.cliphist}/bin/cliphist-fuzzel-img
  '';
in
{
  home.file.".local/share/icons/hicolor/scalable/apps/clipboard-history-picker.svg".source =
    "${pkgs.papirus-icon-theme}/share/icons/Papirus/24x24/apps/com.github.cryptowyrm.copypastegrab.svg";
  # Make sure Blueman desktop icons always resolve in launchers.
  home.file.".local/share/icons/hicolor/scalable/apps/blueman.svg".source =
    "${pkgs.blueman}/share/icons/hicolor/scalable/apps/blueman.svg";
  home.file.".local/share/icons/hicolor/scalable/devices/blueman-device.svg".source =
    "${pkgs.blueman}/share/icons/hicolor/scalable/devices/blueman-device.svg";

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    networkmanagerapplet
    blueman
    pavucontrol
    playerctl
    clipboardHistoryPicker
  ];

  xdg.desktopEntries = {
    # Use an icon that is shipped with networkmanagerapplet in hicolor, so it
    # resolves even when legacy icon names are missing in the active theme.
    "nm-connection-editor" = {
      name = "Advanced Network Configuration";
      comment = "Manage and change your network connection settings";
      exec = "nm-connection-editor";
      icon = "nm-device-wireless";
      terminal = false;
      type = "Application";
      categories = [
        "Settings"
        "Network"
      ];
    };

    # Keep the CLI utility available, but hide it from graphical app menus.
    "uuctl" = {
      name = "uuctl";
      genericName = "User unit manager";
      comment = "Select and perform actions on user systemd units";
      exec = "uuctl";
      icon = "utilities-terminal";
      terminal = true;
      type = "Application";
      noDisplay = true;
      categories = [
        "Utility"
        "Settings"
      ];
    };

    "clipboard-history-picker" = {
      name = "Clipboard History";
      genericName = "Clipboard Manager";
      comment = "Browse clipboard history with image previews";
      exec = "clipboard-history-picker";
      icon = "clipboard-history-picker";
      terminal = false;
      type = "Application";
      categories = [
        "Utility"
        "Office"
      ];
      settings.Keywords = "clipboard;history;cliphist;paste;";
    };
  };
}
