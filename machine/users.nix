{
  pkgs,
  username,
  userHome,
  ...
}:

{
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

  # Also needed here, not just in user/shell.nix: the login shell is set above,
  # so the machine has to know zsh exists.
  programs.zsh.enable = true;
}
