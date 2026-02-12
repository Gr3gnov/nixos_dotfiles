{ ... }:

let
  social_workspace = "3";

  telegramClass = "^(org.telegram.desktop|telegram-desktop|TelegramDesktop)$";
  discordClass = "^(discord|Discord)$";
  yandexMusicClass = "^(yandex-music-web|chrome-music\\.yandex\\.com(--|__-)Default)$";
in
{
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "preset-ws3-yandex-music";
      "match:class" = yandexMusicClass;
      workspace = "${social_workspace} silent";
      float = "yes";
      size = "760 1370";
      move = "10 60";
    }
    {
      name = "preset-ws3-telegram";
      "match:class" = telegramClass;
      workspace = "${social_workspace} silent";
      float = "yes";
      size = "850 1370";
      move = "790 60";
    }
    {
      name = "preset-ws3-discord";
      "match:class" = discordClass;
      workspace = "${social_workspace} silent";
      float = "yes";
      size = "1770 1370";
      move = "1660 60";
    }
  ];
}
