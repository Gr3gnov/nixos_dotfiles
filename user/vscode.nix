# VSCode with its extensions and settings from nix. mutableExtensionsDir = false
# makes the extensions directory read-only: installing from the marketplace by
# hand stops working, and everything the editor has is what this file lists.
#
# settings.json is copied in by an activation script rather than declared
# through programs.vscode.profiles.default.userSettings. That option symlinks
# the file into the store, and every write VSCode attempts — picking an
# interpreter, any extension saving state — then fails with EROFS. Copying keeps
# the file writable; this config still wins, because each rebuild puts it back.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  settings = (pkgs.formats.json { }).generate "vscode-settings.json" {
    "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'Fira Code', monospace";
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
    "editor.formatOnSave" = true;
    "workbench.colorTheme" = "Dark Modern";
    "workbench.activityBar.location" = "top";
    "workbench.secondarySideBar.showLabels" = false;
    "git.autofetch" = true;

    # nix-ide talks to nil, which it looks up in PATH — see ./packages.nix.
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      nil.formatting.command = [ "nixfmt" ];
      # Unused while serverPath is nil, kept so switching servers just works.
      nixd = {
        formatting.command = [ "nixfmt" ];
        options.nixos.expr = "(builtins.getFlake \"${config.home.homeDirectory}/Configs\").nixosConfigurations.nixos.options";
      };
    };

    # uv puts the interpreter here; nothing is installed system-wide.
    "python.defaultInterpreterPath" = "\${workspaceFolder}/.venv/bin/python";
    # ruff comes from PATH (./packages.nix, or a project's own devShell),
    # not from the binary the extension ships — that one is built for
    # ordinary distros and only runs here because of nix-ld.
    "ruff.importStrategy" = "fromEnvironment";
  };

  settingsPath = "${config.home.homeDirectory}/.config/Code/User/settings.json";
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      ms-python.debugpy
      ms-python.vscode-python-envs
      charliermarsh.ruff
      jnoortheen.nix-ide
      anthropic.claude-code
    ];
  };

  # Runs after linkGeneration so the store symlink an earlier generation may
  # have left is gone before install writes; without the rm, install would
  # follow that symlink into the read-only store and fail.
  home.activation.vscodeSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    $DRY_RUN_CMD rm -f ${settingsPath}
    $DRY_RUN_CMD install -Dm644 ${settings} ${settingsPath}
  '';
}
