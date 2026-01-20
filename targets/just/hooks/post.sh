#!/bin/sh

if [ -d ~/.local/share/bash-completion/completions/ ]; then
    just --completions bash > ~/.local/share/bash-completion/completions/just-completions.bash
fi

if [ -d ~/.config/zsh/ ]; then
    just --completions zsh > ~/.config/zsh/just-completions.zsh
fi
