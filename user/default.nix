# Everything that is yours rather than the machine's: it runs as you, at login,
# and writes under ~. If the option you want starts with home./xdg./
# systemd.user., or is a home-manager programs.* module, it belongs here.
#
# There are no enable flags — a file listed here is on. To turn something off,
# comment out its import.
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

    ./plasma # shortcuts, keyboard layout, KWin
    ./zen # browser, policies and extensions
    ./vicinae.nix # launcher on Meta+Space
    ./mangohud.nix # gaming overlay layout
  ];

  home.username = username;
  home.homeDirectory = userHome;

  programs.home-manager.enable = true;

  # Avatar shown by SDDM and the Plasma user switcher.
  home.file.".face.icon".source = ../assets/avatar.jpg;

  # The home-manager release this profile was first built with. Do not bump it.
  home.stateVersion = "25.11";
}
