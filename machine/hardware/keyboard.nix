# macOS-style modifiers, done at the XKB level so they apply everywhere: the
# SDDM greeter, the TTYs, and every app. user/plasma/input.nix repeats this for
# the Plasma session, which keeps its own copy of the layout.
{ ... }:

{
  services.xserver.xkb = {
    layout = "us,ru";
    # Physical Cmd -> logical Control, so Cmd+C/V/T/W behave like macOS.
    # Physical Ctrl then becomes Super and is free for desktop shortcuts.
    # Physical Cmd+Space toggles the layout.
    options = "grp:ctrl_space_toggle,ctrl:swap_lwin_lctl,ctrl:swap_rwin_rctl";
  };

  # Same layout on the TTYs.
  console.useXkbConfig = true;
}
