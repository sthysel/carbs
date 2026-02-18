# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Spacemacs configuration directory that's part of the CARBS dotfiles system. It contains the primary Spacemacs init file (`init.el`) which configures Emacs with Vim-style keybindings and various development layers.

## File Structure

- `init.el`: Main Spacemacs configuration file with three core functions:
  - `dotspacemacs/layers`: Layer configuration and package selection
  - `dotspacemacs/init`: Initial startup settings (fonts, themes, keybindings)
  - `dotspacemacs/user-config`: User-specific runtime configuration (loads external configs)
- `org-gtd.el`: External org-mode GTD configuration, loaded from `user-config`. Contains all org-agenda, capture templates, todo keywords, refile targets, roam setup, and screenshot helpers.
- `bak-init.el`: Backup of previous init.el configuration
- `elfeed.org`: RSS feed configuration (currently empty)
- `.spacemacs.env`: Environment variables loaded by Spacemacs

## Key Configuration Details

### Active Layers

The configuration enables these Spacemacs layers (init.el:34-73):
- **Languages**: lua, html, javascript, csv, toml, yaml, python, ansible, markdown, emacs-lisp
- **Development**: lsp, auto-completion, syntax-checking, version-control, git, treemacs
- **Editor**: better-defaults, helm, multiple-cursors, spell-checking
- **Org mode**: org-roam, org-roam-ui, org-appear, org-transclusion, verb
- **AI**: llm-client with gptel (Claude + Perplexity backends)
- **Python**: Uses LSP backend with `pet` for virtualenv management

### Org Mode — GTD Setup (`org-gtd.el`)

All org-mode configuration lives in `org-gtd.el`, loaded via:
```elisp
(load (expand-file-name "org-gtd" (file-name-directory dotspacemacs-filepath)))
```

Key details:
- **GTD workflow**: Capture → inbox.org → refile to todo.org/someday.org/tickler.org → archive.org
- **Agenda files**: `~/org/inbox.org`, `~/org/todo.org`, `~/org/tickler.org`
- **TODO states**: `TODO(t)` → `NEXT(n)` → `WAITING(w@/!)` → `DONE(d!)` / `CANCELLED(c@/!)`; also `SOMEDAY(s)`
- **Capture templates**: `t` (todo), `n` (next), `w` (waiting), `s` (someday), `T` (tickler), `j` (journal), `m` (meeting)
- **Agenda views**: `d` (dashboard), `w` (weekly review), `n` (next actions), `c` (by context)
- **Tags**: `@work`, `@home`, `@errand`, `phone`, `email`, `read`, `code`
- **Org-roam**: directory `~/org/roam/`, templates for default note, quick note, screenshot
- **Screenshots**: grim+slurp pipeline, saves to `~/org/roam/assets/YYYY-MM/`
- **Habits**: `org-habit` loaded via `with-eval-after-load 'org` (required — `org-modules` is void before org loads)

When editing `org-gtd.el`, note:
- Variables that depend on org being loaded must use `with-eval-after-load 'org`
- `spacemacs/set-leader-keys` is safe to call at top level (runs inside `user-config`)
- Roam capture templates use backquote (`` ` ``) for the screenshot link interpolation

### LSP Configuration

LSP clients registered inside `(with-eval-after-load 'lsp-mode ...)` in `user-config`:
- `ty-lsp`: Python type checker (priority 10)
- `ruff-lsp`: Python linter/formatter
- `yamlls`: YAML
- `just-lsp`: Justfiles
- `rumdl-lsp`: Markdown
- `bash-ls`, `ansible-ls`, `dockerfile-ls`, `semgrep-ls`
- `pylsp` is explicitly disabled

Servers only start when a matching buffer is opened (no session restore — `dotspacemacs-auto-resume-layouts` is `nil`).

### AI Integration (gptel)

- Primary backend: Claude (Anthropic) — `claude-sonnet-4-20250514`
- Secondary backend: Perplexity (sonar)
- API keys via `~/.authinfo` (`gptel-api-key-from-auth-source`)
- Keybindings: `SPC a g` (chat), `SPC a G` (send region)

### Appearance and Behavior

- Editing style: Vim mode
- Font: Source Code Pro, 10pt
- Themes: spacemacs-dark (primary), spacemacs-light
- Leader key: `SPC`, Major mode leader: `,`
- Line numbers: Disabled by default
- Undo system: `undo-fu`
- Session restore: Disabled (clean start, use `SPC p p` for projects)

## Editing the Configuration

### Modifying Layers

Edit `dotspacemacs-configuration-layers` in `dotspacemacs/layers`.

### Modifying Org/GTD Setup

Edit `org-gtd.el` directly. Changes take effect on `SPC f e R` or restart.

### Testing Changes

1. Reload: `SPC f e R`
2. Restart if layer changes: `SPC q R`
3. Batch test for load errors: `emacs --batch --eval "(progn (setq dotspacemacs-filepath \"~/.config/spacemacs/init.el\") (load (expand-file-name \"org-gtd\" (file-name-directory (expand-file-name dotspacemacs-filepath)))))"`

## Org Directory Layout

```
~/org/
├── inbox.org           # capture landing pad
├── todo.org            # active projects and next actions
├── someday.org         # someday/maybe items
├── tickler.org         # deferred/scheduled reminders
├── journal.org         # daily journal (datetree)
├── meetings.org        # meeting notes (datetree)
├── archive.org         # completed/cancelled items
├── templates/
│   └── roam-default.template
└── roam/
    ├── *.org           # roam notes
    └── assets/YYYY-MM/ # screenshots
```

## Integration with CARBS

Deployed via CAIFS: `caifs add -d targets spacemacs`
- Source: `targets/spacemacs/config/.config/spacemacs/`
- Target: `~/.config/spacemacs/`

## Important Notes

- Do not edit below the "Do not write anything past this comment" line in init.el — Emacs manages `custom-set-variables` automatically
- Uses Spacemacs "develop" branch with emacs-git on Arch Linux
