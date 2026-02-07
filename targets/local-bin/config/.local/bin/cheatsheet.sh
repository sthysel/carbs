#!/bin/bash
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

    while IFS= read -r line; do
        local func_name
        func_name=$(echo "$line" | sed -E 's/^function ([a-zA-Z_][a-zA-Z0-9_]*)\(\).*/\1/')
        entry "$func_name()" "function"
    done < <(grep -E "^function " "$HOME/.config/zsh/alias.zsh")
}

emit_scripts() {
    printf '\0markup-rows\x1ftrue\n'
    if [ ! -d "$HOME/.local/bin" ]; then
        return
    fi

    find "$HOME/.local/bin" -maxdepth 1 \( -type f -executable -o -type l \) 2>/dev/null | sort | while read -r script; do
        local script_name
        script_name=$(basename "$script")
        case "$script_name" in
            activate-global-python-argcomplete|aws|aws_completer|az|az.bat|az.completion.sh)
                ;;
            *)
                sub "$script_name"
                ;;
        esac
    done
}

emit_just() {
    printf '\0markup-rows\x1ftrue\n'
    if ! command -v just >/dev/null 2>&1; then
        return
    fi

    just --summary 2>/dev/null | tr ' ' '\n' | sort | while read -r cmd; do
        [ -n "$cmd" ] && sub "just $cmd"
    done
}

# Rofi script mode: $1 is the section name, $2 (if present) is the selected entry (ignored)
case "$1" in
    hyprland)
        emit_hyprland
        ;;
    zsh)
        emit_zsh
        ;;
    scripts)
        emit_scripts
        ;;
    just)
        emit_just
        ;;
    *)
        # Launch rofi with all sections as modi - Tab to switch
        rofi -show Hyprland \
            -modi "Hyprland:$SCRIPT_PATH hyprland,Zsh:$SCRIPT_PATH zsh,Scripts:$SCRIPT_PATH scripts,Just:$SCRIPT_PATH just" \
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
