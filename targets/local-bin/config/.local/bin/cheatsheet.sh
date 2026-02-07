#!/bin/bash
# cheatsheet: System cheatsheet (Super + /)
# shellcheck disable=SC2129
# System cheatsheet via rofi modi - Tab to switch sections
# Usage: called directly to launch rofi, or by rofi as a script mode provider

SCRIPT_PATH="$(readlink -f "$0")"

# Pango helpers - output to stdout for rofi script mode
entry() { printf "<span weight='bold' font_family='monospace' color='#cdd6f4'>%-26s</span>  <span color='#a6adc8'>%s</span>\n" "$1" "$2"; }
sub()   { echo "<span color='#585b70'>$1</span>"; }

emit_hyprland() {
    printf '\0markup-rows\x1ftrue\n'
    if [ ! -f "$HOME/.config/hypr/binds.conf" ]; then
        return
    fi

    local comment="" last_group="" group_keys="" group_mod=""
    local lines=()

    while IFS= read -r line; do
        if [[ "$line" =~ ^#\ (.+) ]]; then
            comment="${BASH_REMATCH[1]}"
            continue
        fi
        if [[ -z "$line" ]]; then
            comment=""
            last_group=""
            continue
        fi
        if [[ ! "$line" =~ ^bind ]]; then
            continue
        fi

        # shellcheck disable=SC2016
        local keys mod key combo desc
        keys=$(echo "$line" | sed -E 's/^bind[eml]* = //' | sed 's/\$mainMod/Super/g')
        mod=$(echo "$keys" | cut -d',' -f1 | xargs)
        key=$(echo "$keys" | cut -d',' -f2 | xargs)

        if [ -n "$mod" ]; then
            combo="$mod + $key"
        else
            combo="$key"
        fi

        desc="${comment//mainMod/Super}"
        if [ -z "$desc" ] && [[ "$line" =~ \#\ (.+)$ ]]; then
            desc="${BASH_REMATCH[1]}"
        fi
        if [ -z "$desc" ]; then
            desc=$(echo "$keys" | cut -d',' -f3 | xargs)
        fi

        # Collapse repeated groups into one line
        if [ -n "$comment" ] && [ "$comment" = "$last_group" ] && [ "$mod" = "$group_mod" ]; then
            unset 'lines[${#lines[@]}-1]'
            group_keys="$group_keys, $key"
            if [ -n "$mod" ]; then
                lines+=("$(entry "$mod + {$group_keys}" "$desc")")
            else
                lines+=("$(entry "{$group_keys}" "$desc")")
            fi
        else
            last_group="$comment"
            group_keys="$key"
            group_mod="$mod"
            lines+=("$(entry "$combo" "$desc")")
        fi
    done < "$HOME/.config/hypr/binds.conf"

    printf '%s\n' "${lines[@]}"
}

emit_zsh() {
    printf '\0markup-rows\x1ftrue\n'
    if [ ! -f "$HOME/.config/zsh/alias.zsh" ]; then
        return
    fi

    while IFS= read -r line; do
        local alias_def name value
        alias_def="${line#alias }"
        name="${alias_def%%=*}"
        value="${alias_def#*=}"
        value="${value#\"}"
        value="${value%\"}"
        value="${value#\'}"
        value="${value%\'}"
        entry "$name" "$value"
    done < <(grep -E "^alias " "$HOME/.config/zsh/alias.zsh")

    # Parse functions with preceding comment as description
    local comment=""
    while IFS= read -r line; do
        if [[ "$line" =~ ^#\ (.+) ]]; then
            comment="${BASH_REMATCH[1]}"
            continue
        fi
        if [[ "$line" =~ ^function\ ([a-zA-Z_][a-zA-Z0-9_]*) ]]; then
            entry "${BASH_REMATCH[1]}()" "${comment:-function}"
            comment=""
        fi
    done < "$HOME/.config/zsh/alias.zsh"
}

emit_scripts() {
    printf '\0markup-rows\x1ftrue\n'
    if [ ! -d "$HOME/.local/bin" ]; then
        return
    fi

    # Only show scripts with a "# cheatsheet: <description>" marker
    grep -Rl '# cheatsheet: ' "$HOME/.local/bin" 2>/dev/null | sort | while read -r script; do
        local script_name desc
        script_name=$(basename "$script")
        desc=$(grep -m1 '^# cheatsheet: ' "$script" | sed 's/^# cheatsheet: //')
        entry "$script_name" "$desc"
    done
}

# Strip pango markup to get plain text
strip_markup() { sed 's/<[^>]*>//g' <<< "$1" | xargs; }

# Execute selection: $1=section, $2=selected entry (with markup)
# Output nothing to close rofi, or re-emit the list to stay open
run_selection() {
    local section="$1" selected="$2"
    local plain
    plain=$(strip_markup "$selected")

    case "$section" in
        scripts)
            # First word is the script name
            local script_name="${plain%% *}"
            if [ -x "$HOME/.local/bin/$script_name" ]; then
                coproc kitty -e "$HOME/.local/bin/$script_name"
            fi
            ;;
    esac
}

# Rofi script mode: $1 is the section name
# ROFI_RETV=1 means user selected an entry, passed as $2
case "$1" in
    hyprland)
        emit_hyprland
        ;;
    zsh)
        emit_zsh
        ;;
    scripts)
        if [ "${ROFI_RETV:-0}" -eq 1 ] && [ -n "$2" ]; then
            run_selection scripts "$2"
        else
            emit_scripts
        fi
        ;;
    *)
        # Launch rofi with all sections as modi - Tab to switch
        rofi -show Hyprland \
            -modi "Hyprland:$SCRIPT_PATH hyprland,Aliases:$SCRIPT_PATH zsh,Scripts:$SCRIPT_PATH scripts" \
            -markup-rows -no-show-icons \
            -theme-str 'window { width: 55%; height: 75%; }' \
            -theme-str 'listview { columns: 1; lines: 50; spacing: 0px; scrollbar: true; fixed-height: false; }' \
            -theme-str 'element { padding: 2px 8px; spacing: 0px; border-radius: 4px; }' \
            -theme-str 'element-icon { size: 0px; }' \
            -theme-str 'element-text { font: "monospace 10"; vertical-align: 0.5; }' \
            -theme-str 'inputbar { padding: 4px 8px; }' \
            -theme-str 'mainbox { children: [inputbar, mode-switcher, listview]; }' \
            -theme-str 'mode-switcher { spacing: 0; }' \
            -theme-str 'button { padding: 4px 12px; text-color: @fg0; }' \
            -theme-str 'button selected { background-color: @accent; text-color: #000000; border-radius: 4px; }'
        ;;
esac
