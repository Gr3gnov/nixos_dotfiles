{
  virtualDesktops = {
    number = 4;
    rows = 1;
  };

  # Gap around quick-tiled windows.
  tiling.padding = 6;

  # Replaces the old hand-rolled hyprsunset script.
  nightLight = {
    enable = true;
    mode = "times";
    time = {
      morning = "07:00";
      evening = "20:00";
    };
    temperature = {
      day = 6500;
      night = 3500;
    };
    transitionTime = 30;
  };

  effects = {
    minimization.animation = "magiclamp";
    windowOpenClose.animation = "scale";
  };
}
