# Steam has to be on the machine side: it wants 32-bit drivers, firewall rules
# and setcap wrappers, none of which home-manager can set.
# The MangoHud binary comes from here; your overlay layout is user/mangohud.nix.
{ lib, pkgs, ... }:

{
  hardware.graphics.enable32Bit = lib.mkDefault true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    # setcap cap_sys_nice on the gamescope binary so it can raise its own
    # scheduler priority — smoother frame pacing under load.
    capSysNice = true;
  };

  programs.gamemode = {
    enable = true;
    # When a game activates gamemode, renice it above normal desktop tasks.
    settings.general.renice = 10;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
    protonup-qt
    nvtopPackages.full
    vulkan-tools
    mesa-demos
  ];
}
