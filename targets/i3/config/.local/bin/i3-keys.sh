#!/bin/bash

# Default directory to search (current directory if not specified)
DIR="${1:-.}"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

# Temporary file to store parsed bindings
TEMP_FILE=$(mktemp)


# Function to parse files and extract bindings with comments
parse_files() {
    local current_category="default"

    # Use process substitution to avoid subshell issues with the find command's results
    while IFS= read -r file; do
        # Use mapfile to safely read the entire file into an array
        local lines=()
        mapfile -t lines < "$file"

        # Process lines by index
        for i in "${!lines[@]}"; do
            local line="${lines[i]}"

            # Check for category comments
            if [[ $line =~ ^[[:space:]]*#[[:space:]]*Category:[[:space:]]*(.+) ]]; then
                current_category="${BASH_REMATCH[1]}"
                read -r current_category <<< "$current_category"
            # Check for bindsym lines
            elif [[ $line =~ ^[[:space:]]*bindsym[[:space:]]+(.*) ]]; then
                local binding="${BASH_REMATCH[1]}"
                # Remove inline comments for cleaner output
                binding="${binding%%#*}"
                read -r binding <<< "$binding"

                # Look for comments in the lines immediately above this bindsym
                local comment=""
                local j=$((i-1))
                while [[ $j -ge 0 ]]; do
                    local prev_line="${lines[j]}"

                    # Check if it's a comment BUT NOT a Category line
                    if [[ $prev_line =~ ^[[:space:]]*# ]] && [[ ! $prev_line =~ Category: ]]; then
                        # Now that we know it's a valid comment, extract its text.
                        [[ $prev_line =~ ^[[:space:]]*#[[:space:]]*(.*) ]]
                        local comment_text="${BASH_REMATCH[1]}"
                        read -r comment_text <<< "$comment_text"

                        # Prepend the comment, building a multi-line comment string
                        if [[ -n "$comment_text" ]]; then
                            if [[ -n "$comment" ]]; then
                                comment="$comment_text; $comment"
                            else
                                comment="$comment_text"
                            fi
                        fi
                        ((j--))
                    elif [[ $prev_line =~ ^[[:space:]]*$ ]]; then
                        # It's an empty line, continue looking up
                        ((j--))
                    else
                        # It's a command, a category line, or something else. Stop.
                        break
                    fi
                done

                echo "$current_category|$binding|$comment"
            fi
        done
    done < <(find "$DIR" -type f \( -name "*.conf" -o -name "config" -o -name "*.config" \))
}

# Parse files and sort by category
parse_files | sort > "$TEMP_FILE"

# Function to print table header
print_header() {
    echo "╔════════════╦════════════════════════════════════════════════════════════════════════════════╦══════════════════════════════════╗"
    echo "║Category    ║Binding                                                                         ║Comments                          ║"
    echo "╟────────────╫────────────────────────────────────────────────────────────────────────────────╫──────────────────────────────────╢"
}

# Function to print table footer
print_footer() {
    echo "╚════════════╩════════════════════════════════════════════════════════════════════════════════╩══════════════════════════════════╝"
}

# Function to print a row
print_row() {
    local category="$1"
    local binding="$2"
    local comment="$3"
    local is_first_in_category="$4"

    # Truncate fields if too long
    if [ ${#binding} -gt 79 ]; then
        binding="${binding:0:76}..."
    fi
    if [ ${#comment} -gt 32 ]; then
        comment="${comment:0:29}..."
    fi

    if [ "$is_first_in_category" = "true" ]; then
        printf "║%-12s║ %-79s ║ %-32s ║\n" "$category" "$binding" "$comment"
    else
        printf "║%-12s║ %-79s ║ %-32s ║\n" "" "$binding" "$comment"
    fi
}

# Function to print category separator
print_separator() {
    echo "╟────────────╫────────────────────────────────────────────────────────────────────────────────╫──────────────────────────────────╢"
}

# Main table printing logic
print_table() {
    print_header

    local current_category=""
    local first_in_category=true
    local has_content=false

    while IFS='|' read -r category binding comment; do
        if [ -n "$category" ] && [ -n "$binding" ]; then
            has_content=true

            if [ "$category" != "$current_category" ]; then
                if [ -n "$current_category" ]; then
                    print_separator
                fi
                current_category="$category"
                first_in_category=true
            fi

            print_row "$category" "$binding" "$comment" "$first_in_category"
            first_in_category=false
        fi
    done < "$TEMP_FILE"

    if [ "$has_content" = true ]; then
        print_footer
    else
        echo "No keybindings found in the specified directory."
    fi
}

# Execute the main function
print_table

# Clean up
rm -f "$TEMP_FILE"
