{
  assetsDir,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.app.yandexMusicWeb;
  appName = "Yandex Music";
  appId = "yandex-music-web";
  appUrl = "https://music.yandex.com/";
  generatedAppIds = [
    "chrome-music.yandex.com--Default"
    "chrome-music.yandex.com__-Default"
  ];
  appCategories = [
    "AudioVideo"
    "Audio"
    "Player"
    "Network"
  ];
  appExec = "${pkgs.chromium}/bin/chromium --class=${appId} --hide-scrollbars --force-app-mode --app=${appUrl}";
  commonDesktop = {
    name = appName;
    exec = appExec;
    icon = appId;
    terminal = false;
    type = "Application";
  };
  generatedDesktopEntries = lib.genAttrs generatedAppIds (_: commonDesktop // {
    categories = appCategories;
    noDisplay = true;
  });
  yandexIconPath = assetsDir + "/yandex-music.svg";
in
{
  options.my.app.yandexMusicWeb.enable = lib.mkEnableOption "Yandex Music web app in Chromium";

  config = lib.mkIf cfg.enable {
    home.file.".local/share/icons/hicolor/scalable/apps/${appId}.svg".source =
      yandexIconPath;

    xdg.desktopEntries = {
      "${appId}" = commonDesktop // {
        categories = appCategories;
      };
    }
    // generatedDesktopEntries;
  };
}
