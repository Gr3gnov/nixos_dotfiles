{ ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      enable = true;
      extraConfig."10-bluetooth-a2dp-only" = {
        # Avoid HFP/HSP profile negotiation issues that can block connection on
        # some headsets — AirPods among them.
        "monitor.bluez.properties" = {
          "bluez5.hfphsp-backend" = "native";
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
          ];
        };
      };
    };
  };
}
