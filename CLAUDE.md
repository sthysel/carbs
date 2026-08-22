# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

CARBS (Chad Arch Random Bootstrap Scripts) is a dotfiles and system provisioning tool for Arch Linux. It bootstraps fresh Arch installations into configured development environments and manages dotfiles across multiple machines.

The project uses [CAIFS](https://github.com/caifs-org/caifs) as the primary tool to install and to maintain the system. A legacy Ansible layer (`ansible/`) is still present, but it is in the process of removal.

## Repository Layout

```
targets/     # CAIFS targets: dotfiles and package installation (primary)
ansible/     # Legacy playbooks and roles
workbench/   # One-off maintenance scripts for this repo, not deployed
notes/       # Reference notes, not deployed
pics/        # Screenshots for the readme
install.sh   # Bootstrap script for a fresh machine
justfile     # Task runner recipes
```

## Architecture

### CAIFS Targets (Primary)

CAIFS manages dotfiles and package installations through targets in `targets/`:

```
targets/<package>/
├── readme.org    # What the target does (most targets have one)
├── config/       # Files to symlink (mirrored to $HOME)
│   ├── .config/  # -> ~/.config/
│   ├── .local/   # -> ~/.local/
│   └── ^etc/     # -> /etc/ (root filesystem, sudo auto-escalated)
└── hooks/        # Installation scripts
    ├── pre.sh    # Before symlinking (install deps)
    ├── post.sh   # After symlinking (enable services)
    └── rm.sh     # During removal (cleanup)
```

A leading `^` in a config path targets `/` instead of `$HOME`. For example, `config/^etc/systemd/system/foo.service` symlinks to `/etc/systemd/system/foo.service`. CAIFS escalates privileges automatically. Prefer `^` config paths over writing files in hook scripts.

Hooks support OS-specific functions. CAIFS runs the function that matches the detected platform:

```sh
arch() { yay -S package; }      # Arch Linux
steamos() { ... }               # Steam Deck
debian() { apt install pkg; }   # Debian/Ubuntu
```

CAIFS also supplies helper functions to hooks. Do not define them in the hook:

- `yay_install <packages...>`: install AUR or repository packages
- `log_info <message>`: print a progress message

To list the available targets, run `ls targets/` or `caifs status -d targets`.

### Ansible (Legacy)

The `ansible/` directory holds playbooks and roles for system provisioning. CAIFS targets replace this layer.

- Playbooks: `desktop.yml`, `wsl.yml`, and machine-specific ones (`vive.yml`, `aero.yml`, `impi.yml`, `tv.yml`, `twinks.yml`, `tablets.yml`, `syu.yml`)
- Roles: `ansible/roles/` (run `ls ansible/roles/` to see the available roles)
- Variables: `ansible/roles/base/group_vars/all.yml` (sets `carbs_user`)

## Common Commands

### Fresh Machine

`install.sh` clones the repository to `~/.config/dotfiles`, installs `yay` and `caifs`, then deploys the `bootstrap` target:

```bash
curl -fsSL https://raw.githubusercontent.com/sthysel/carbs/main/install.sh | bash
```

### CAIFS (Primary)

```bash
caifs add -d targets zsh           # Deploy target + run hooks
caifs add -d targets -l zsh        # Symlink only (no hooks)
caifs add -d targets -h zsh        # Run hooks only (no symlinks)
caifs add -d targets -f wallpaper  # Force deploy (override conflicts)
caifs add -d targets '*'           # Deploy all targets
caifs rm -d targets nvim           # Undeploy target
caifs status -d targets            # Show deployment status
```

### Just Recipes

```bash
just dotfiles                        # Deploy all targets via CAIFS
just qa-install-hooks                # Install pre-commit hooks
just qa-all                          # Run all QA checks
just deploy                          # Run Ansible desktop playbook (legacy)
just deploy localhost audio,music    # Deploy specific Ansible tags (legacy)
just deploy-wsl                      # Deploy WSL playbook (legacy)
just tv-bootstrap                    # Bootstrap the media center as root (legacy)
```

### Ansible (Legacy)

```bash
just deploy localhost hyprland desktop    # Deploy specific tags
uv run ansible-playbook -v --ask-become-pass --inventory ansible/inventory/ ansible/vive.yml
```

## Development Workflow

### Adding a New Target

1. Create the target directory: `targets/<name>/`
2. Add config files in `targets/<name>/config/` that mirror the home directory structure.
   - Use `config/.config/` for user config (`~/.config/`)
   - Use `config/^etc/` for system config (`/etc/`), which requires sudo
3. Add `hooks/pre.sh` to install dependencies. Use the `yay_install` helper.
4. Optional: add `hooks/post.sh` for post-install setup, for example to enable services.
5. Add `readme.org` to describe the target.
6. Test with `caifs add -d targets <name>`.

### Making Changes

1. Edit the target configs in `targets/<package>/config/`.
2. Test the changes: `caifs add -d targets -f <package>`.
3. Verify that QA passes: `just qa-all`.
4. Commit the changes. Pre-commit hooks run automatically.

Deployed configs are symlinks back into this repository. An edit to the live file in `~/.config/` is an edit to the target file. Do not edit both.

## Important Notes

- The target systems are Arch Linux: physical machines, WSL, and Steam Deck.
- The `yay` AUR helper is required. `install.sh` and `targets/bootstrap` install it.
- Pre-commit enforces YAML validation, shellcheck, trailing whitespace, private key detection, secret detection, shebang consistency, and a 1 MB file size limit.
- The `ansible-lint` hook is commented out in `.pre-commit-config.yaml`.
- Run `shellcheck` on every hook script before you consider the work done.
