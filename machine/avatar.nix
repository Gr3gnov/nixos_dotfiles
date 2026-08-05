# The login screen's copy of the user avatar.
#
# user/default.nix already links the picture into ~/.face.icon, but that copy is
# invisible here: SDDM's greeter runs as the `sddm` user and the home directory
# is mode 0700. SDDM then falls back to FacesDir, which /etc/sddm.conf.d points
# at /run/current-system/sw/share/sddm/faces — the system profile — so the
# picture has to arrive as a package.
{ pkgs, username, ... }:

{
  environment.systemPackages = [
    (pkgs.runCommand "sddm-face-${username}" { } ''
      install -Dm444 ${../assets/avatar.jpg} $out/share/sddm/faces/${username}.face.icon
    '')
  ];
}
