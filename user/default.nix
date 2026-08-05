{
  username,
  userHome,
  ...
}:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./terminal.nix
    ./cursor.nix

    ./plasma
    ./zen
    ./vicinae.nix
    ./mangohud.nix

  home.username = username;
  home.homeDirectory = userHome;

  programs.home-manager.enable = true;

  home.file.".face".source = ../assets/avatar.jpg;
  home.file.".face.icon".source = ../assets/avatar.jpg;

  home.stateVersion = "25.11";
}
