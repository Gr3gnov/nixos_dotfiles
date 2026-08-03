{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.my.app.zen;
  addons = inputs.addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # The profile lives in ~/.config/zen — both this module and the browser moved
  # there from the legacy ~/.zen in 2026. If ~/.zen ever reappears the browser
  # prefers it, silently starting an unmanaged profile where none of the
  # settings or extensions below apply; deleting it is the fix.
  imports = [ inputs.zen-browser.homeModules.default ];

  options.my.app.zen.enable = lib.mkEnableOption "Zen browser with policies & extensions";

  config = lib.mkIf cfg.enable (
    let
      # Upstream dropped meta.desktopFileName in 2026; keep reading it when
      # present and fall back to the name the package actually ships.
      zenDesktopFile = config.programs.zen-browser.package.meta.desktopFileName or "zen-beta.desktop";
    in
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "default-web-browser" = [ zenDesktopFile ];
          "text/html" = [ zenDesktopFile ];
          "x-scheme-handler/http" = [ zenDesktopFile ];
          "x-scheme-handler/https" = [ zenDesktopFile ];
          "x-scheme-handler/about" = [ zenDesktopFile ];
          "x-scheme-handler/unknown" = [ zenDesktopFile ];
        };
      };

      programs.zen-browser = {
        enable = true;
        policies = import ./policies.nix { inherit addons; };

        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;

          extensions.packages = import ./extensions.nix { inherit addons; };
          settings = import ./settings.nix;
        };
      };
    }
  );
}
