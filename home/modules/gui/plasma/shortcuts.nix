{
  programs.plasma = {
    # Actually, prntscrn, which is sent by shift+ctrl+4
    configFile.kglobalshortcutsrc."org.kde.spectacle.desktop".RectangularRegionScreenShot = "Ctrl+$\tCtrl+;,,";

    shortcuts = {
      kwin = {
        "Window Close" = "Ctrl+Q";
      };
      plasmashell = {
        "activate application launcher" = "none";
      };
    };
  };
}
