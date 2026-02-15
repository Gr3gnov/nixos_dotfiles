{
  assetsDir,
  lib,
  pkgs,
  username,
  ...
}:

let
  xdgDataDirs = lib.concatStringsSep ":" [
    "/home/${username}/.nix-profile/share"
    "/etc/profiles/per-user/${username}/share"
    "/nix/var/nix/profiles/default/share"
    "/run/current-system/sw/share"
  ];
  avatarPath = assetsDir + "/avatar.jpg";
in

{
  programs.caelestia = {
    enable = true;
    cli.enable = true;
    settings.services = {
      useFahrenheit = false;
      weatherLocation = "";
    };
    settings.bar.status = {
      showAudio = true;
      showMicrophone = false;
      showKbLayout = true;
      showNetwork = true;
      showWifi = true;
      showBluetooth = true;
      showBattery = true;
      showLockStatus = true;
    };
    settings.bar.popouts.activeWindow = false;
    settings.bar.entries = [
      {
        id = "logo";
        enabled = true;
      }
      {
        id = "workspaces";
        enabled = true;
      }
      {
        id = "spacer";
        enabled = true;
      }
      {
        id = "activeWindow";
        enabled = false;
      }
      {
        id = "spacer";
        enabled = true;
      }
      {
        id = "tray";
        enabled = true;
      }
      {
        id = "clock";
        enabled = true;
      }
      {
        id = "statusIcons";
        enabled = true;
      }
      {
        id = "power";
        enabled = true;
      }
    ];
    systemd = {
      enable = true;
      environment = [
        "QT_QPA_PLATFORMTHEME=adwaita"
        "QT_STYLE_OVERRIDE=adwaita-dark"
        "XDG_DATA_DIRS=${xdgDataDirs}"
      ];
    };
  };

  xdg.configFile."caelestia/avatar.jpg".source = avatarPath;
  home.file.".face".source = avatarPath;

  home.packages = with pkgs; [
    adwaita-icon-theme
    hicolor-icon-theme
    brightnessctl
    ddcutil
  ];
}
