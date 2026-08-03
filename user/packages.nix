# Programs that need no configuration. Anything that does gets its own file
# next to this one, named after it.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    telegram-desktop
    discord
    spotify
    zathura

    nixfmt # formatter for this repo

    # CLI helpers Plasma's own tools do not cover.
    wl-clipboard
    playerctl
  ];
}
