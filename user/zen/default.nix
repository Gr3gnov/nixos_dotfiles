# Zen browser. Split across four files:
#   default.nix     wiring and which app opens links
#   policies.nix    enterprise policies (what the browser is not allowed to do)
#   extensions.nix  the extension list
#   settings.nix    about:config prefs
# An extension only needs a policy entry if it must be locked or pre-approved;
# otherwise extensions.nix alone is enough.
#
# The profile lives in ~/.config/zen — both this module and the browser moved
# there from the legacy ~/.zen in 2026. If ~/.zen ever reappears the browser
# prefers it, silently starting an unmanaged profile where none of the settings
# below apply; deleting it is the fix.
{
  inputs,
  pkgs,
  config,
  ...
}:

let
  addons = inputs.addons.packages.${pkgs.stdenv.hostPlatform.system};

  # Upstream dropped meta.desktopFileName in 2026; keep reading it when present
  # and fall back to the name the package actually ships.
  zenDesktopFile = config.programs.zen-browser.package.meta.desktopFileName or "zen-beta.desktop";
in
{
  imports = [ inputs.zen-browser.homeModules.default ];

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
