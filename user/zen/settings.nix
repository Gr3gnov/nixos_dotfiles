{
  # Extensions
  "extensions.autoDisableScopes" = 0;

  # Language
  # Translation target defaults to the first preferred page language.
  "intl.accept_languages" = "ru-RU,ru,en-US,en";

  # Theme
  # No activeThemeID here on purpose: Zen ships its own theming, and pointing
  # this at a Firefox theme that is not installed did nothing.
  "layout.css.prefers-color-scheme.content-override" = 0;
  "devtools.theme" = "dark";
  "ui.systemUsesDarkTheme" = 1;

  # Notification
  "permissions.default.desktopNotification" = 2;

  # PiP is off. The hover toggle only exists to start PiP, so it went with it —
  # flip this to true to get both back.
  "media.videocontrols.picture-in-picture.enabled" = false;
}
