{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    networkmanagerapplet
    blueman
    pavucontrol
  ];
}
