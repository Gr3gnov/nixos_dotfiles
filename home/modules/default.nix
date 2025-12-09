{ config, pkgs, ... }:

{
  imports = [
    ./shell/shell.nix
    ./gui/terminal.nix
    ./gui/hyprland.nix
    ./app
  ];
}
