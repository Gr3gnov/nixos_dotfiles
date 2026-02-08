{
  config,
  lib,
  pkgs,
  username,
  userHome,
  ...
}:

let
  cfg = config.my.core.user;
in
{
  options.my.core.user.enable = lib.mkEnableOption "Primary user config";

  config = lib.mkIf cfg.enable {
    users.users.${username} = {
      isNormalUser = true;
      description = username;
      home = userHome;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
