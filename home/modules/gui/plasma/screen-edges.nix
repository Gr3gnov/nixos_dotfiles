{
  programs.plasma.configFile.kwinrc = {
    EdgeBarrier = {
      CornerBarrier = {
        value = false;
        immutable = true;
      };
      EdgeBarrier = {
        value = 0;
        immutable = true;
      };
    };

    ElectricBorders = {
      TopLeft = {
        value = "None";
        immutable = true;
      };
      Top = {
        value = "None";
        immutable = true;
      };
      TopRight = {
        value = "None";
        immutable = true;
      };
      Right = {
        value = "None";
        immutable = true;
      };
      BottomRight = {
        value = "None";
        immutable = true;
      };
      Bottom = {
        value = "None";
        immutable = true;
      };
      BottomLeft = {
        value = "None";
        immutable = true;
      };
      Left = {
        value = "None";
        immutable = true;
      };
    };

    "Effect-overview" = {
      BorderActivate = {
        value = 9;
        immutable = true;
      };
    };

    "Effect-windowview" = {
      BorderActivate = {
        value = 9;
        immutable = true;
      };
    };
  };
}
