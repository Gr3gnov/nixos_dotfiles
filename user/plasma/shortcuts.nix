# Reminder while reading key names below: the XKB swap in ./input.nix means
# "Meta" is the physically-Ctrl key and "Ctrl" is the physically-Cmd key.
# So "Meta+Q" is pressed as Ctrl+Q, and "Ctrl+Shift+4" as Cmd+Shift+4.
{
  kwin = {
    # Window management
    "Window Close" = "Meta+Q";
    "Window Maximize" = "Meta+F";
    "Window Minimize" = "Meta+M";

    # Quick tiling — the Rectangle-style half/quarter snapping.
    "Window Quick Tile Left" = "Meta+Shift+Left";
    "Window Quick Tile Right" = "Meta+Shift+Right";
    "Window Quick Tile Top" = "Meta+Shift+Up";
    "Window Quick Tile Bottom" = "Meta+Shift+Down";

    # Focus
    "Switch Window Left" = "Meta+Left";
    "Switch Window Right" = "Meta+Right";
    "Switch Window Up" = "Meta+Up";
    "Switch Window Down" = "Meta+Down";

    "Overview" = "Meta+Tab";

    # Virtual desktops
    "Switch to Desktop 1" = "Meta+1";
    "Switch to Desktop 2" = "Meta+2";
    "Switch to Desktop 3" = "Meta+3";
    "Switch to Desktop 4" = "Meta+4";

    # The MX Master 4's Back/Forward buttons send exactly these — logid maps
    # them to Ctrl+comma and Ctrl+dot, which the XKB swap turns into Meta.
    # See machine/hardware/logid.cfg.
    "Switch to Previous Desktop" = "Meta+,";
    "Switch to Next Desktop" = "Meta+.";

    "Window to Desktop 1" = "Meta+Shift+1";
    "Window to Desktop 2" = "Meta+Shift+2";
    "Window to Desktop 3" = "Meta+Shift+3";
    "Window to Desktop 4" = "Meta+Shift+4";
  };

  # Keep the macOS screenshot muscle memory: physical Cmd+Shift+4 / +5.
  "org.kde.spectacle.desktop" = {
    RectangularRegion = "Ctrl+Shift+4";
    FullScreen = "Ctrl+Shift+5";
  };
}
