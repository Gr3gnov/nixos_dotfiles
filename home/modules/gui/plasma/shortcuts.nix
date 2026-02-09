{
  programs.plasma = {
    # Actually, prntscrn, which is sent by shift+ctrl+4
    configFile.kglobalshortcutsrc."org.kde.spectacle.desktop".RectangularRegionScreenShot = "Ctrl+$\tCtrl+;,,";

    shortcuts = {
      kwin = {
        "Window Close" = "Ctrl+Q";
        "Walk Through Windows" = "Ctrl+Tab";
        "Walk Through Windows (Reverse)" = "Ctrl+Shift+Tab";
        "Walk Through Windows of Current Application" = "Alt+Tab";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+Shift+Tab";
      };
      plasmashell = {
        "activate application launcher" = "none";
      };
    };
  };
}
