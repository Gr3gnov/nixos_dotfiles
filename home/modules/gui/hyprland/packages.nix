{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    wttrbar
    networkmanagerapplet
    blueman
    pavucontrol
  ];
}
