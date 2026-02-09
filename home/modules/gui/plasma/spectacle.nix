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
}
