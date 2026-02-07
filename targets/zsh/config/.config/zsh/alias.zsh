# shellcheck shell=bash
# general aliases
alias vim='nvim'
alias e='nvim'
alias ls='lsd'
alias l='ls -l'
alias ll="ls -lahF"
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias tree='tree -CFa -I ".mypy_cache|.git|__pycache__|.venv" --dirsfirst'

# force password prompt ssh, for when keys are broken or weird
alias pssh='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# pandoc markdown to rst
alias md2rst='pandoc --from=markdown --to=rst --output=README.rst README.md'

# emotive package management
alias yeet="yay -Rcs"

# force Webex to use XWayland for working dialogs
alias webex="env QT_QPA_PLATFORM=xcb WAYLAND_DISPLAY='' /opt/Webex/bin/CiscoCollabHost"

# I forget sudo
alias please='sudo $(fc -ln -1)'

alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -' # Jump to last dir

# make dir and enter
function mkcd() { mkdir -p "$1" && cd "$1" || return; }

# cd into ~/.local/bin
function cdtools() { cd ~/.local/bin/"$1" && ls || return; }

# file manager
function y() {
    local tmp
    tmp="$(mktemp)"
    yazi --cwd-file="$tmp" "$@"
    if [ -s "$tmp" ]; then
        cd "$(cat "$tmp")" || return
    fi
    rm -f "$tmp"
}
# if I forget "yazi", I may remember "file manager"
alias fm='y'

# extract any archive format
function extract () {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "Unknown format: $1" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
