{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.core.fonts;
in
{
  options.my.core.fonts.enable = lib.mkEnableOption "System fonts";

  config = lib.mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        fira-code-symbols
        nerd-fonts.fira-code
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };
}
