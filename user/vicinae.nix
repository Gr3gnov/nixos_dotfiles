# Raycast-style launcher. The upstream home-manager module is deliberately not
# used: it assigns programs.google-chrome.nativeMessagingHosts unconditionally,
# an option this home-manager does not have. Running the daemon ourselves is a
# few lines and one dependency less.
{ pkgs, ... }:

let
  vicinae = "${pkgs.vicinae}/bin/vicinae";
in
{
  home.packages = [ pkgs.vicinae ];

  systemd.user.services.vicinae = {
    Unit = {
      Description = "Vicinae server daemon";
      Documentation = [ "https://docs.vicinae.com" ];
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${vicinae} server";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Meta+Space is physically Ctrl+Space — see ./plasma/input.nix for why.
  programs.plasma.hotkeys.commands.vicinae-toggle = {
    name = "Toggle Vicinae";
    key = "Meta+Space";
    command = "${vicinae} toggle";
  };
}
