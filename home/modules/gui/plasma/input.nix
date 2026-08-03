{
  keyboard = {
    layouts = [
      { layout = "us"; }
      { layout = "ru"; }
    ];

    # Mirror of services.xserver.xkb on the system side, so the greeter, the
    # TTYs and the Plasma session all agree:
    #   physical Cmd  -> logical Control (Cmd+C/V/T/W behave like macOS)
    #   physical Ctrl -> logical Meta    (free for desktop shortcuts below)
    #   physical Cmd+Space toggles the layout
    options = [
      "grp:ctrl_space_toggle"
      "ctrl:swap_lwin_lctl"
      "ctrl:swap_rwin_rctl"
    ];

    numlockOnStartup = "on";
  };
}
