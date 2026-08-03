# NixOS configuration

One desktop machine (`nixos`, x86_64), one user (`nekr0nk`). KDE Plasma 6 on
Wayland, NVIDIA, Zen browser, Steam. NixOS and home-manager are applied together
by a single rebuild.

## Commands

```bash
osrebuild    # git add . && sudo nixos-rebuild switch --flake .#nixos
osupdate     # nix flake update && the same switch
nfmt         # nixfmt over every .nix file here
```

Those are zsh aliases from `user/shell.nix`. To check a change without applying
it:

```bash
nixos-rebuild build --flake .#nixos
```

**New files must be `git add`ed before a rebuild** — a flake only sees
git-tracked files. That is why `osrebuild` starts with `git add .`.

If a rebuild breaks the desktop, pick the previous generation in the boot menu.
Nothing is lost; 15 generations are kept.

## Layout

```
flake.nix          inputs, and the two halves wired together
machine/           needs root, applies to every user   -> NixOS options
user/              runs as you, writes under ~         -> home-manager options
assets/            files referenced by config (avatar)
```

The split is not a preference — it follows which option namespace a setting
lives in. Steam is in `machine/` because it sets `hardware.graphics.enable32Bit`
and firewall rules, which home-manager cannot do. Vicinae is in `user/` because
it is a `systemd.user` service.

| Option starts with | Goes in |
|---|---|
| `services.` `hardware.` `boot.` `networking.` `security.` `environment.` | `machine/` |
| `home.` `xdg.` `systemd.user.` | `user/` |
| `programs.` | either — try one, the build tells you within seconds |

Some things live in both halves, and that is correct: `machine/gaming.nix`
installs the MangoHud binary, `user/mangohud.nix` holds your overlay layout.
`machine/desktop.nix` installs Plasma, `user/plasma/` configures it for you.

## Adding something

**One rule:** needs configuration → its own file, named after it. Needs none →
append to `packages.nix` of the right half.

A new file has to be listed in the `imports` of the half it belongs to
(`machine/default.nix` or `user/default.nix`). That is the whole ceremony — there
are no enable flags. A file that is imported is on; to turn it off, comment out
its import line.

Modules are plain attribute sets, no boilerplate:

```nix
{ pkgs, ... }:
{
  programs.foo.enable = true;
}
```

## Configuring Plasma

Change it in System Settings first, then capture it:

```bash
nix run github:nix-community/plasma-manager#rc2nix
```

That prints the Nix for what you just clicked. Paste the part worth keeping into
`user/plasma/`. Finding a setting by clicking beats reading option docs.

`overrideConfig` is `false` in `user/plasma/default.nix`, so settings made in the
GUI survive a rebuild. Setting it to `true` makes these files the only source of
truth and resets everything else at next login.

## Things that will bite

- `machine/hardware-configuration.nix` is generated. Do not hand-edit it.
- `system.stateVersion` and `home.stateVersion` record the release each was
  first built with. They are not a version to keep current — leave them alone.
- Zen keeps its profile in `~/.config/zen`. If a `~/.zen` directory ever appears,
  the browser silently prefers it and starts an unmanaged profile with none of
  the config in `user/zen/`. Delete `~/.zen` to fix.
- The keyboard has macOS-style modifiers via XKB (`machine/hardware/keyboard.nix`):
  physical Cmd acts as Control, physical Ctrl acts as Meta. So a shortcut written
  `Meta+Q` is pressed as Ctrl+Q, and `Ctrl+Shift+4` as Cmd+Shift+4.
- nixpkgs tracks the **stable** channel on purpose. Bumping it to unstable will
  work and will also make breakage routine.

## Flake inputs

| Input | Used by |
|---|---|
| `home-manager` | the whole `user/` half |
| `plasma-manager` | `user/plasma/` |
| `zen-browser` | `user/zen/` |
| `addons` (rycee firefox-addons) | extensions and policies in `user/zen/` |
| `claude-code-nix` | overlay providing `pkgs.claude-code` in `machine/packages.nix` |
