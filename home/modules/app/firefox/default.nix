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
  zen-package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  options.my.app.firefox.enable = lib.mkEnableOption "Zen with policies & extensions";
  
  config = lib.mkIf cfg.enable {
    
    home.packages = [ zen-package ];
    
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/about" = [ "zen.desktop" ];
        "x-scheme-handler/unknown" = [ "zen.desktop" ];
        "application/pdf" = [ "zen.desktop" ];
      };
    };

    programs.firefox = {
      enable = true;
      
      package = lib.makeOverridable (conf: pkgs.runCommand "firefox-dummy" {} ''
        mkdir -p $out/bin
        touch $out/bin/firefox 
        chmod +x $out/bin/firefox
      '') {};

      policies = import ./policies.nix;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions.packages = import ./extensions.nix { inherit firefox-addons; };
        settings = import ./settings.nix;
      };
    };

    home.file.".zen".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.mozilla/firefox";
    
  }; 
}
