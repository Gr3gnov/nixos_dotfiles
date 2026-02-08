{
  pkgs,
  username,
  userHome,
  ...
}:

{
  imports = [
    ../modules
  ];

  home.username = username;
  home.homeDirectory = userHome;

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  my.gui.terminal.enable = true;
  my.shell.zsh.enable = true;
  my.app.zen.enable = true;

  home.packages = with pkgs; [
    vscode
    nixfmt
    telegram-desktop
    discord
    yandex-music
  ];

}
