{ config, pkgs, ... }:

{
  imports = [
    ./shell/shell.nix
    ./gui/terminal.nix
    ./gui/plasma-shortcuts.nix
    ./app
  ];
}
