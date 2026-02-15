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
    }:
    {
      inherit name;
      "match:class" = classRegex;
      workspace = "${socialWorkspace} silent";
    };
in
{
  wayland.windowManager.hyprland.settings.windowrule = [
    (mkSocialRule {
      name = "preset-ws3-yandex-music";
      classRegex = yandexMusicClass;
    })
    (mkSocialRule {
      name = "preset-ws3-telegram";
      classRegex = telegramClass;
    })
    (mkSocialRule {
      name = "preset-ws3-discord";
      classRegex = discordClass;
    })
  ];
}
