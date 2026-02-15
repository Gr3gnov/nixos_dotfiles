{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    networkmanagerapplet
    blueman
    pavucontrol
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
  };
}
