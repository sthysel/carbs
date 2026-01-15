#!/bin/sh

if [ -d ~/.local/share/bash-completion/completions/ ]; then
    just --completions bash > ~/.local/share/bash-completion/completions/just-completions.bash
fi

if [ -d ~/.zshrc.d/ ]; then
    just --completions zsh > ~/.zshrc.d/just-completions.zsh
fi
