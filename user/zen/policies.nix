{ addons, ... }:
let
  getAddonId =
    addon:
    if addon ? addonId then
      addon.addonId
    else if addon ? passthru && addon.passthru ? addonId then
      addon.passthru.addonId
    else
      throw "Addon has no addonId";

  extensionIds = {
    ublockOrigin = getAddonId addons."ublock-origin";
    bitwarden = getAddonId addons.bitwarden;
    sponsorblock = getAddonId addons.sponsorblock;
    translateWebPages = getAddonId addons."translate-web-pages";
  };
in
{
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  ExtensionSettings = {
    "${extensionIds.ublockOrigin}" = {
      private_browsing = true;
    };
    "${extensionIds.bitwarden}" = {
      private_browsing = true;
    };
    "${extensionIds.sponsorblock}" = {
      private_browsing = true;
    };
    "${extensionIds.translateWebPages}" = {
      private_browsing = true;
    };
  };
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
  };
  DisableFirefoxAccounts = true;
  DisableAccounts = true;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  DontCheckDefaultBrowser = true;
  DisplayBookmarksToolbar = "always";
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
}
