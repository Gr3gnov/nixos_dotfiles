# Packages every user on this machine gets. Things only you need go in
# user/packages.nix instead.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    claude-code
  ];
}
