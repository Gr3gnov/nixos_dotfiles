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

  # Home modules
  my.gui.terminal.enable = true;
  my.gui.cursor.enable = true;
  my.gui.plasma.enable = true;
  my.shell.zsh.enable = true;
  my.app.zen.enable = true;
  my.app.mangohud.enable = true;
  my.app.vicinae.enable = true;

  # User-facing desktop apps
  home.packages = with pkgs; [
    vscode
    nixfmt
    telegram-desktop
    discord
    spotify
    zathura

    # CLI helpers that Plasma's own tools do not cover.
    wl-clipboard
    playerctl
  ];
}
