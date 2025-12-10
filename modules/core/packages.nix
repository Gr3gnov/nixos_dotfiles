{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.my.core.essentials;
in
{
  options.my.core.essentials.enable = lib.mkEnableOption "Essential Packages & Fonts";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Code
      antigravity
      git

      # Theming
      papirus-icon-theme
      bibata-cursors
    ];
    fonts.packages = with pkgs; [
      fira-code-symbols
      nerd-fonts.fira-code 
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
