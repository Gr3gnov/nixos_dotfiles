{
  assetsDir,
  pkgs,
  ...
}:

let
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
        id = "clock";
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
