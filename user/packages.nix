# Programs that need no configuration. Anything that does gets its own file
# next to this one, named after it.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    telegram-desktop
    discord
    spotify

    nixfmt # formatter for this repo
    # Language tooling VSCode's extensions pick up from PATH — see ./vscode.nix.
    # No Python interpreter here on purpose: uv downloads the version each
    # project asks for.
    uv
    ruff
    nil # Nix language server

    # CLI helpers Plasma's own tools do not cover.
    wl-clipboard
    playerctl
  ];
}
