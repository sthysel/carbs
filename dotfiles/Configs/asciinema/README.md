# Asciinema Package

Tuckr package for asciinema terminal session recording and gif generation.

## What's Included

- **asciinema** (v3.0.1+): Terminal session recorder
- **asciinema-agg** (v1.7.0+): Converts recordings to animated GIFs
- Configuration file with sensible defaults

## Installation

```bash
# Link the asciinema configs (triggers pre-hook to install packages)
tuckr add asciinema

# Or link all configs
tuckr set *
```

The pre-hook script will automatically install:
- `asciinema` - Terminal session recorder
- `asciinema-agg` - GIF generator (installed from AUR)

## Usage

### Recording Sessions

```bash
# Record a session
asciinema rec demo.cast

# Record with a title
asciinema rec -t "My Demo" demo.cast

# Record and append to existing file
asciinema rec -a demo.cast
```

### Playback

```bash
# Play back a recording
asciinema play demo.cast

# Play at 2x speed
asciinema play -s 2 demo.cast
```

### Generate GIFs

```bash
# Convert recording to GIF (note: command is 'agg', not 'asciinema-agg')
agg demo.cast demo.gif

# Customize GIF settings
agg --speed 2 --font-size 14 demo.cast demo.gif
```

### Upload and Share

```bash
# Upload to asciinema.org
asciinema upload demo.cast

# Record and upload in one step
asciinema rec
# (Press Ctrl-D when done, will prompt to upload)
```

## Configuration

The configuration file is located at `~/.config/asciinema/config` and includes:

### Recording Settings
- **Command**: `/usr/bin/zsh` (default shell)
- **Idle time limit**: 2 seconds (cuts long pauses in recordings)
- **Stdin recording**: Enabled

### Playback Settings
- **Speed**: 1x (normal)
- **Idle time limit**: 2 seconds (speeds up pauses during playback)

These defaults make recordings more professional by automatically trimming long idle periods.

## Files

```
dotfiles/
├── Configs/asciinema/
│   ├── .config/asciinema/
│   │   └── config          # Configuration file
│   └── README.md           # This file
└── Hooks/asciinema/
    └── pre.sh              # Pre-hook installation script
```

## Notes

- The asciinema-agg binary is installed as `agg`, not `asciinema-agg`
- Recordings are stored as `.cast` files (JSON format)
- GIF generation may take time for longer recordings
- Config symlink: `~/.config/asciinema/config` -> `dotfiles/Configs/asciinema/.config/asciinema/config`

## Links

- [asciinema documentation](https://docs.asciinema.org/)
- [asciinema-agg GitHub](https://github.com/asciinema/agg)
