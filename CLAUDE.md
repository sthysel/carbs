# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

CARBS (Chad Arch Random Bootstrap Scripts) is an Ansible-based system provisioning tool for Arch Linux. It bootstraps fresh Arch installations into configured development environments and manages dotfiles across multiple machines. The project uses `uv` for Python dependency management and `just` as a task runner.

## Architecture

### Core Components

- **Ansible Playbooks**: Main orchestration layer in `ansible/` directory
  - `desktop.yml`: Full desktop environment setup (Hyprland, audio, fonts, Docker, etc.)
  - `wsl.yml`: Minimal WSL development environment
  - Machine-specific playbooks: `aero.yml`, `vive.yml`, `twinks.yml`, `impi.yml`, `tablets.yml`, `syu.yml`

- **Ansible Roles** (`ansible/roles/`): Modular configuration units
  - `base`: Core system setup (users, locale, entropy, reflector, nobeep)
  - `hyprland`: Hyprland Wayland compositor environment
  - `i3`: i3 window manager (alternative to Hyprland)
  - `audio`: Audio system configuration
  - `docker`: Container runtime setup
  - `python-dev`: Python development environment
  - `spacemacs`: Emacs/Spacemacs editor setup
  - `fonts`: Font installation and configuration
  - `ssh`: SSH configuration
  - `disks`: Disk mounting and management
  - `beets`: Music library management
  - `yazi`: Terminal file manager
  - Hardware-specific: `dell-xps`, `nvidia`, `navigation`
  - `smoketest`: Validation role

- **Dotfiles**: Managed via [CAIFS](https://github.com/caifs-org/caifs)
  - Structure: `targets/<package>/config/.config/<app>/` or `targets/<package>/config/.local/`
  - Each subdirectory in `targets/` represents a dotfile target (e.g., `zsh/`, `nvim/`, `hyprland/`, `kitty/`)
  - CAIFS creates symlinks from `targets/<pkg>/config/` into `$HOME`
  - `targets/<pkg>/hooks/`: Pre/post/rm scripts for packages (e.g., `targets/nvim/hooks/post.sh`)
  - `lib/lib.sh`: Shared helper functions for hooks (OS detection, package installers)

- **Inventory** (`ansible/inventory/hosts.yml`): Host groups and connection settings
  - `desktop` group: Multiple named hosts plus localhost
  - `ewaste` group: For older hardware
  - Uses local connection for localhost operations

### Configuration Flow

1. Bootstrap phase: Install `uv`, then use it to install Ansible and dependencies
2. Ansible phase: Run playbooks to install packages and configure system via roles
3. Dotfiles phase: Use `caifs` to symlink configuration files into place
4. Post-install: Run QA checks via pre-commit hooks

## Common Commands

### Bootstrap and Deployment

```bash
# Bootstrap from scratch (first-time setup)
just bootstrap

# Deploy desktop playbook to localhost (interactive, asks for sudo password)
just deploy

# Deploy specific tags only
just deploy localhost audio,music desktop

# Deploy to WSL environment
just deploy-wsl

# Deploy to remote host (use machine-specific playbook)
uv run ansible-playbook -v --ask-become-pass --inventory ansible/inventory/ ansible/vive.yml
```

### Direct Ansible Usage

```bash
# Run specific tags on localhost
ansible-playbook ./ansible/desktop.yml -i 'localhost,' --ask-become-pass --tags hyprland --connection local

# Run on remote host with its playbook
ansible-playbook ./ansible/vive.yml -i vive, --ask-become-pass --tags hyprland
```

### Dotfiles Management

```bash
# Link all dotfiles using CAIFS
just dotfiles

# Remove broken symlinks from ~/.config/
just remove-danglinks

# Manual CAIFS operations
caifs add -d targets zsh           # Link zsh configs + run hooks
caifs add -d targets -l zsh        # Link only (no hooks)
caifs add -d targets -h zsh        # Run hooks only (no links)
caifs rm -d targets nvim           # Unlink nvim configs
caifs status -d targets            # Check dotfile status
caifs add -d targets -f wallpaper  # Force link (override conflicts)
caifs add -d targets '*'           # Deploy all targets
```

### Quality Assurance

```bash
# Install pre-commit hooks
just qa-install-pre-commit-hooks

# Run all QA checks (pre-commit on all files)
just qa-all
```

### Utilities

```bash
# Install/update yay AUR helper
just install-yay

# Install uv package manager
just install-uv

# Install Ansible via uv
just install-ansible

# Fix argcomplete issues
just fix-argcomplete
```

## Development Workflow

### Making Changes

1. Edit ansible roles in `ansible/roles/<role>/tasks/main.yml`
2. Update dotfiles in `targets/<package>/config/` subdirectories
3. Test changes locally: `just deploy localhost <relevant-tags> desktop`
4. Verify QA passes: `just qa-all`
5. Commit changes (pre-commit hooks will run automatically)

### Adding New Roles

1. Create role directory: `ansible/roles/<name>/`
2. Add `tasks/main.yml` with role tasks
3. Optional: Add `handlers/main.yml`, `defaults/main.yml`, `meta/main.yml`
4. Add role to appropriate playbook in `ansible/` directory
5. Tag the role appropriately for selective deployment

### Working with Tags

Roles use tags for selective deployment:
- `audio`, `music`: Audio system and music tools
- `fonts`: Font installation
- `editor`, `dev`: Development tools
- `container`: Docker/containerization
- `hyprland`: Wayland compositor
- `python`: Python development environment
- `disks`: Disk management
- `beets`: Music library
- `yazi`: File manager

### Inventory and Variables

- Host definitions: `ansible/inventory/hosts.yml`
- Global variables: `ansible/group_vars/all.yml` (sets `carbs_user`)
- Ansible config: `ansible.cfg` (sets inventory and roles path)

## Important Notes

- This is a personal system configuration - fork and adapt for your own use
- Designed for Arch Linux systems (physical machines, WSL, VMs)
- Requires network connectivity and working sudo/wheel group access
- Uses AUR helper `yay` for AUR packages (installed via `just install-yay`)
- Python dependencies managed via `uv` with lockfile (`uv.lock`)
- Pre-commit hooks enforce YAML validation, trailing whitespace, secret detection
- Secret detection baseline: `.secrets.baseline` (excludes lazy-lock.json, yazi/package.toml)
