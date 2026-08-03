{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hardware.keyboard;
in
{
  options.my.hardware.keyboard.enable =
    lib.mkEnableOption "Keyboard layout with macOS-style modifiers";

  config = lib.mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "us,ru";
      # Physical Cmd -> logical Control, so Cmd+C/V/T/W behave like macOS.
      # Physical Ctrl then becomes Super and is free for desktop shortcuts.
      # Physical Cmd+Space toggles the layout.
      options = "grp:ctrl_space_toggle,ctrl:swap_lwin_lctl,ctrl:swap_rwin_rctl";
    };

    # Same layout on the TTYs.
    console.useXkbConfig = true;
  };
}
