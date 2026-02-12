{ lib, ... }:

let
  socialWorkspace = "3";

  telegramClass = "^(org.telegram.desktop|telegram-desktop|TelegramDesktop)$";
  discordClass = "^(discord|Discord)$";

  # Chromium app windows can expose class names in multiple generated forms.
  yandexMusicClasses = [
    "yandex-music-web"
    "chrome-music\\.yandex\\.com(--|__-)Default"
  ];
  yandexMusicClass = "^(${lib.concatStringsSep "|" yandexMusicClasses})$";

  mkSocialRule =
    {
      name,
      classRegex,
      size,
      move,
    }:
    {
      inherit name size move;
      "match:class" = classRegex;
      workspace = "${socialWorkspace} silent";
      float = "yes";
    };
in
{
  wayland.windowManager.hyprland.settings.windowrule = [
    (mkSocialRule {
      name = "preset-ws3-yandex-music";
      classRegex = yandexMusicClass;
      size = "760 1370";
      move = "10 60";
    })
    (mkSocialRule {
      name = "preset-ws3-telegram";
      classRegex = telegramClass;
      size = "850 1370";
      move = "790 60";
    })
    (mkSocialRule {
      name = "preset-ws3-discord";
      classRegex = discordClass;
      size = "1770 1370";
      move = "1660 60";
    })
  ];
}
