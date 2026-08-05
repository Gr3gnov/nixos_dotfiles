# SDDM's greeter runs as `sddm` and cannot read ~/.face.icon (home is 0700), so
# the login screen takes its avatar from FacesDir in the system profile.
{ pkgs, username, ... }:

{
  environment.systemPackages = [
    (pkgs.runCommand "sddm-face-${username}" { } ''
      install -Dm444 ${../assets/avatar.jpg} $out/share/sddm/faces/${username}.face.icon
    '')
  ];
}
