{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.core.user;
in
{
  options.my.core.user.enable = lib.mkEnableOption "Nekr0nk User Config";

  config = lib.mkIf cfg.enable {
    users.users.nekr0nk = {
      isNormalUser = true;
      description = "nekr0nk";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = [ ];
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
