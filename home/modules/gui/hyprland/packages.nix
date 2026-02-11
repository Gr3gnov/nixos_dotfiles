{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    grim
    slurp
    wl-clipboard
  ];
}
