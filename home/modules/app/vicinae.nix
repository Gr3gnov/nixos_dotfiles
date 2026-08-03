{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.app.vicinae;
  vicinae = "${pkgs.vicinae}/bin/vicinae";
in
{
  options.my.app.vicinae.enable = lib.mkEnableOption "Vicinae launcher (Raycast-style)";

  # The upstream home-manager module is not used on purpose: it assigns
  # programs.google-chrome.nativeMessagingHosts unconditionally, an option this
  # home-manager does not have. Running the daemon ourselves is a few lines.
  config = lib.mkIf cfg.enable {
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

    # Meta+Space is physically Ctrl+Space — see gui/plasma/input.nix for why.
    programs.plasma.hotkeys.commands.vicinae-toggle = {
      name = "Toggle Vicinae";
      key = "Meta+Space";
      command = "${vicinae} toggle";
    };
  };
}
