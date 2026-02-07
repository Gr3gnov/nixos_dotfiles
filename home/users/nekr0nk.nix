{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../modules
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.username = "nekr0nk";
  home.homeDirectory = "/home/nekr0nk";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
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

  programs.plasma = {
    enable = true;
    input.keyboard = {
      layouts = [
        { layout = "us"; }
        { layout = "ru"; }
      ];
      options = [
        "grp:ctrl_space_toggle"
        "ctrl:swap_lwin_lctl"
        "ctrl:swap_rwin_rctl"
      ];
    };
  };
}
