# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

CARBS (Chad Arch Random Bootstrap Scripts) is a dotfiles and system provisioning tool for Arch Linux. It bootstraps fresh Arch installations into configured development environments and manages dotfiles across multiple machines.

The project uses [CAIFS](https://github.com/caifs-org/caifs) as the primary tool for installing and maintaining the system. There is also a legacy Ansible layer (`ansible/`) which is being phased out.

## Architecture

### CAIFS Targets (Primary)

Dotfiles and package installations are managed via CAIFS targets in `targets/`:

```
targets/<package>/
├── config/       # Files to symlink (mirrored to $HOME)
│   ├── .config/  # -> ~/.config/
│   └── .local/   # -> ~/.local/
└── hooks/        # Installation scripts
    ├── pre.sh    # Before symlinking (install deps)
    ├── post.sh   # After symlinking (enable services)
    └── rm.sh     # During removal (cleanup)
```

Hooks support OS-specific functions that execute based on the detected platform:

```sh
arch() { yay -S package; }      # Arch Linux
steamos() { ... }               # Steam Deck
debian() { apt install pkg; }   # Debian/Ubuntu
```

Available targets can be listed with `ls targets/` or `caifs status -d targets`.

### Ansible (Legacy)

The `ansible/` directory contains playbooks and roles for system provisioning. This is legacy infrastructure being replaced by CAIFS targets.

- Playbooks: `desktop.yml`, `wsl.yml`, and machine-specific (`vive.yml`, `aero.yml`, etc.)
- Roles: `ansible/roles/` (run `ls ansible/roles/` to see available roles)
- Variables: `ansible/roles/base/group_vars/all.yml` (sets `carbs_user`)

## Common Commands

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
just deploy                          # Run Ansible desktop playbook (legacy)
just deploy localhost audio,music    # Deploy specific Ansible tags (legacy)
just deploy-wsl                      # Deploy WSL playbook (legacy)
just qa-install-hooks                # Install pre-commit hooks
just qa-all                          # Run all QA checks
```

### Ansible (Legacy)

```bash
just deploy localhost hyprland desktop    # Deploy specific tags
uv run ansible-playbook -v --ask-become-pass --inventory ansible/inventory/ ansible/vive.yml
```

## Development Workflow

### Adding a New Target

1. Create target directory: `targets/<name>/`
2. Add config files in `targets/<name>/config/` mirroring home directory structure
3. Add `hooks/pre.sh` to install dependencies (use `yay_install` helper)
4. Optional: Add `hooks/post.sh` for post-install setup (enable services, etc.)
5. Test with `caifs add -d targets <name>`

### Making Changes

1. Edit target configs in `targets/<package>/config/`
2. Test changes: `caifs add -d targets -f <package>`
3. Verify QA passes: `just qa-all`
4. Commit changes (pre-commit hooks run automatically)

## Important Notes

- Designed for Arch Linux systems (physical machines, WSL, Steam Deck)
- Requires `yay` AUR helper (installed via `targets/bootstrap`)
- Pre-commit hooks enforce YAML validation, shellcheck, trailing whitespace, secret detection
