# How Nix itself behaves.
{ ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  # Rolling back to a previous generation is the safety net here, so the window
  # has to be wide enough to notice a problem in. This has to stay in step with
  # boot.loader.systemd-boot.configurationLimit: whichever is smaller wins, and
  # a 3-day sweep would make a 15-entry boot menu meaningless.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;
}
