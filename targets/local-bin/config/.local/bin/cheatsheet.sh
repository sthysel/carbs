#!/bin/bash
# shellcheck disable=SC2129
# System-wide cheatsheet for Hyprland keybindings, zsh aliases, scripts, and just commands

# Temporary file to store formatted output
CHEATSHEET=$(mktemp)

# Header
echo "=== HYPRLAND KEYBINDINGS ===" >> "$CHEATSHEET"
echo "" >> "$CHEATSHEET"

# Parse Hyprland bindings
if [ -f "$HOME/.config/hypr/binds.conf" ]; then
    # Extract bind lines and format them nicely
    grep -E "^bind[eml]* = " "$HOME/.config/hypr/binds.conf" | while read -r line; do
        # Parse the bind line
        # Format: bind = MOD, KEY, action, params
        # shellcheck disable=SC2016
        binding=$(echo "$line" | sed -E 's/^bind[eml]* = //' | sed 's/\$mainMod/SUPER/g')

        # Clean up and format
        echo "  $binding" >> "$CHEATSHEET"
    done
fi

echo "" >> "$CHEATSHEET"
echo "=== ZSH ALIASES ===" >> "$CHEATSHEET"
echo "" >> "$CHEATSHEET"

# Parse zsh aliases
if [ -f "$HOME/.config/zsh/alias.zsh" ]; then
    # Extract aliases
    grep -E "^alias " "$HOME/.config/zsh/alias.zsh" | while read -r line; do
        # Remove 'alias ' prefix and format
        alias_def="${line#alias }"
        echo "  $alias_def" >> "$CHEATSHEET"
    done

    echo "" >> "$CHEATSHEET"
    echo "  --- Functions ---" >> "$CHEATSHEET"

    # Extract function names
    grep -E "^function " "$HOME/.config/zsh/alias.zsh" | while read -r line; do
        func_name=$(echo "$line" | sed -E 's/^function ([a-zA-Z_][a-zA-Z0-9_]*)\(\).*/\1/')
        # Try to get description from comment above
        echo "  $func_name()" >> "$CHEATSHEET"
    done
fi

echo "" >> "$CHEATSHEET"
echo "=== CUSTOM SCRIPTS (in ~/.local/bin/) ===" >> "$CHEATSHEET"
echo "" >> "$CHEATSHEET"

# List custom scripts
if [ -d "$HOME/.local/bin" ]; then
    find "$HOME/.local/bin" -maxdepth 1 -type f -executable -o -type l 2>/dev/null | sort | while read -r script; do
        script_name=$(basename "$script")
        # Skip some common tools that aren't custom scripts
        case "$script_name" in
            activate-global-python-argcomplete|aws|aws_completer|az|az.bat|az.completion.sh)
                ;;
            *)
                echo "  $script_name" >> "$CHEATSHEET"
                ;;
        esac
    done
fi

echo "" >> "$CHEATSHEET"
echo "=== JUST COMMANDS ===" >> "$CHEATSHEET"
echo "" >> "$CHEATSHEET"

# List just commands if justfile exists
if command -v just >/dev/null 2>&1; then
    just --summary 2>/dev/null | tr ' ' '\n' | sort | while read -r cmd; do
        [ -n "$cmd" ] && echo "  just $cmd" >> "$CHEATSHEET"
    done
fi

# Display with rofi
cat "$CHEATSHEET" | rofi -dmenu -i -p "Cheatsheet" -theme-str 'window {width: 50%; height: 70%;}' -theme-str 'listview {columns: 1;}'

# Cleanup
rm "$CHEATSHEET"
