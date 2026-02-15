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
  imports = [ inputs.zen-browser.homeModules.default ];

  options.my.app.zen.enable = lib.mkEnableOption "Zen browser with policies & extensions";

  config = lib.mkIf cfg.enable (
    let
      zenDesktopFile = config.programs.zen-browser.package.meta.desktopFileName;
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
