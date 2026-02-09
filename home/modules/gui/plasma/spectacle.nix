{
  programs.plasma = {
    configFile.spectaclerc.General.useReleaseToCapture = {
      value = true;
      immutable = true;
    };

    configFile.spectaclerc.General.clipboardGroup = {
      value = 1;
      immutable = true;
    };
  };

  # Override Spectacle notification defaults to suppress popup toasts.
  xdg.dataFile."knotifications6/spectacle.notifyrc".text = ''
    [Global]
    IconName=spectacle
    DesktopEntry=org.kde.spectacle
    Name=Spectacle
    Comment=Screenshot Capture Utility

    [Event/newScreenshotSaved]
    Name=New Screenshot Saved
    Comment=A new screenshot was captured and saved
    Action=None

    [Event/recordingSaved]
    Name=Recording Saved
    Comment=A recording was captured and saved
    Action=None
  '';
}
