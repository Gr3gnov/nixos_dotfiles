{
  config,
  lib,
  ...
}:

let
  cfg = config.my.shell.zsh;
in
{
  options.my.shell.zsh.enable = lib.mkEnableOption "Zsh & Utilities";

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        py = "python3";
        ipy = "ipython";
        # Keep VSCode on XWayland mode to avoid Electron/Wayland issues.
        code = "env -u NIXOS_OZONE_WL code";
        l = "eza -lh --icons=auto";
        ls = "eza -1 --icons=auto";
        ll = "eza -lha --icons=auto --sort=name --group-directories-first";

        gs = "git status";
        gp = "git push";

        repomix = "docker run -v .:/app -it --rm ghcr.io/yamadashy/repomix";
        osrebuild = "git add . && sudo nixos-rebuild switch --flake .#nixos";
        osupdate = "nix flake update && sudo nixos-rebuild switch --flake .#nixos";
        nfmt = "nixfmt $(rg --files -g '*.nix')";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "pip"
          "docker"
          "docker-compose"
          "colorize"
          "command-not-found"
          "common-aliases"
          "extract"
        ];
      };
    };

    programs.starship.enable = true;

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.eza.enable = true;
  };
}
