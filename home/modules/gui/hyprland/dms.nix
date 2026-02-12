{ ... }:
{
  xdg.configFile."DankMaterialShell/settings.json" = {
    source = ./dms-settings.json;
    force = true;
  };
}
