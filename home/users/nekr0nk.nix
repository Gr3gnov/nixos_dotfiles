{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../modules
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

}
