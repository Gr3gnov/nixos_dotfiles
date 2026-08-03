{ pkgs, ... }:

{
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
}
