{
  config,
  lib,
  pkgs,
  ...
}:
let
  settings = (pkgs.formats.json { }).generate "vscode-settings.json" {
    # Editor and window
    "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'Fira Code', monospace";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 16;
    # Scales the whole UI — file tree, tabs, status bar — the way ctrl+plus
    # does; editor.fontSize alone only touches the text being edited.
    "window.zoomLevel" = 0.5;
    "editor.formatOnSave" = true;
    "editor.renderWhitespace" = "boundary";
    "editor.minimap.renderCharacters" = false;
    "editor.multiCursorLimit" = 100000;
    # Both off so Cyrillic in comments stops being flagged as suspicious.
    "editor.unicodeHighlight.ambiguousCharacters" = false;
    "editor.unicodeHighlight.nonBasicASCII" = false;
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;
    "files.trimFinalNewlines" = true;
    "workbench.colorTheme" = "Dark Modern";
    "workbench.iconTheme" = "vscode-icons";
    "workbench.activityBar.location" = "top";
    "workbench.sideBar.location" = "right";
    "workbench.secondarySideBar.showLabels" = false;
    "workbench.startupEditor" = "none";
    "window.customTitleBarVisibility" = "auto";
    "outline.collapseItems" = "alwaysCollapse";
    "explorer.confirmDragAndDrop" = false;
    "security.workspace.trust.untrustedFiles" = "open";
    "vsicons.dontShowNewVersionMessage" = true;

    # Noise that never belongs in the file tree.
    "files.exclude" = {
      ".idea/" = true;
      ".pyre/" = true;
      ".pyre_configuration" = true;
      ".venv" = true;
      "**/*.egg-info" = true;
      "**/*.pyc" = true;
      "**/.coverage" = true;
      "**/.mypy_cache" = true;
      "**/.pytest_cache/" = true;
      "**/.vs/" = true;
      "**/.vscode/" = true;
      "**/__pycache__/" = true;
      "**/htmlcov/" = true;
      "env/" = true;
      "venv/" = true;
    };

    # Terminal
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
    "terminal.integrated.fontSize" = 18;
    "terminal.integrated.scrollback" = 100000;

    # Python. No defaultInterpreterPath: ${workspaceFolder} is only substituted
    # in workspace settings, and the extension finds the .venv uv creates in the
    # project root on its own anyway.
    "[python]" = {
      "editor.defaultFormatter" = "charliermarsh.ruff";
      "editor.formatOnType" = true;
      "editor.codeActionsOnSave"."source.organizeImports" = "explicit";
    };
    # ruff comes from PATH (./packages.nix, or a project's own devShell), not
    # from the binary the extension ships — that one is built for ordinary
    # distros and only runs here because of nix-ld.
    "ruff.importStrategy" = "fromEnvironment";
    "python.languageServer" = "Pylance";
    "python.analysis.typeCheckingMode" = "basic";
    "python.analysis.completeFunctionParens" = true;
    "python.analysis.autoImportCompletions" = true;
    "python.analysis.inlayHints.functionReturnTypes" = true;

    # Nix. nix-ide talks to nil, which it looks up in PATH — see ./packages.nix.
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

    # JSON formatters are built into VSCode, no extension involved.
    "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
    "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";

    # Git
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.suggestSmartCommit" = false;
    "git.blame.editorDecoration.enabled" = true;
    "git.blame.editorDecoration.template" = "[\${authorDateAgo}] \${authorName}: \"\${subject}\"";
    "scm.showChangesSummary" = false;
    "scm.showOutgoingChanges" = "never";

    # Notebooks
    "workbench.editorAssociations"."*.ipynb" = "jupyter-notebook";
    "notebook.cellToolbarLocation" = {
      default = "right";
      jupyter-notebook = "left";
    };
    "notebook.editorOptionsCustomizations" = {
      "editor.tabSize" = 4;
      "editor.indentSize" = 4;
      "editor.insertSpaces" = true;
    };
    "notebook.formatOnSave.enabled" = true;
    "notebook.output.textLineLimit" = 200;
    "jupyter.askForKernelRestart" = false;
    "jupyter.logging.level" = "error";

    # Spell check
    "cSpell.language" = "en,ru";
    "cSpell.userWords" = [
      "Behaviour"
      "Cinemachine"
      "dateutil"
      "deltatime"
      "Lerp"
      "Mathf"
      "Netcode"
      "normalise"
      "structlog"
      "upserted"
      "Workato"
    ];

    "claudeCode.preferredLocation" = "panel";
  };

  cspell-russian = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "streetsidesoftware";
      name = "code-spell-checker-russian";
      version = "2.2.4";
      sha256 = "1za6yszd47kp4jdnw86897d0qxsik5q2grvpaj7xl0rnknxxazsn";
    };
  };

  settingsPath = "${config.home.homeDirectory}/.config/Code/User/settings.json";
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        ms-python.vscode-python-envs
        charliermarsh.ruff
        jnoortheen.nix-ide
        anthropic.claude-code
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        vscode-icons-team.vscode-icons
        streetsidesoftware.code-spell-checker
      ]
      ++ [ cspell-russian ];
  };

  # Runs after linkGeneration so the store symlink an earlier generation may
  # have left is gone before install writes; without the rm, install would
  # follow that symlink into the read-only store and fail.
  home.activation.vscodeSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    $DRY_RUN_CMD rm -f ${settingsPath}
    $DRY_RUN_CMD install -Dm644 ${settings} ${settingsPath}
  '';
}
