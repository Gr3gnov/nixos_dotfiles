{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../modules
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default

  ];

  home.username = "nekr0nk";
  home.homeDirectory = "/home/nekr0nk";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  my.gui.hyprland.enable = true;
  my.gui.terminal.enable = true;
  my.shell.zsh.enable = true;
  my.app.firefox.enable = true;

  home.packages = with pkgs; [
    vscode
    nixfmt-rfc-style
    telegram-desktop
    discord
    yandex-music
  ];
  programs.dankMaterialShell = {
    enable = true;
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
