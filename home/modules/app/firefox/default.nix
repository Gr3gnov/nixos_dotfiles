{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.my.app.firefox;
  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.my.app.firefox.enable = lib.mkEnableOption "Firefox with policies & extensions";
  config = lib.mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" ];
        "application/pdf" = [ "firefox.desktop" ];
      };
    };

    programs.firefox = {
      enable = true;

      # Check about:policies#documentation for options
      policies = import ./policies.nix;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions.packages = import ./extensions.nix { inherit firefox-addons; };
        settings = import ./settings.nix;
      };
    };
  };
}
