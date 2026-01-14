# shellcheck shell=bash
# vim: set filetype=sh :

# shellcheck disable=SC2034  # ZDOTDIR is used by zsh itself
ZDOTDIR="$HOME/.config/zsh"

# Locale
export LANG=en_AU.UTF-8

# Editor and terminal
export VISUAL=nvim
export EDITOR=nvim
export TERMINAL=kitty
export TERM=xterm-kitty
export SPACEMACSDIR=${XDG_CONFIG_DIR}/spacemacs
export MOZ_ENABLE_WAYLAND=1

# Paths
path+=("$HOME/.local/bin" "$HOME/go/bin" "$HOME/.cargo/bin")
export PATH

# Java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'

# CUDA
export CUDA_HOME=/opt/cuda
export NUMBAPRO_CUDA_DRIVER=/usr/lib64/libcuda.so
export NUMBAPRO_LIBDEVICE=/opt/cuda/nvvm/libdevice
export NUMBAPRO_NVVM=/opt/cuda/nvvm/lib64/libnvvm.so
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/opt/cuda/targets/x86_64-linux/lib:/lib/x86_64-linux-gnu"

# GTK scaling
export GDK_SCALE=1
export GDK_DPI_SCALE=1

# SSH agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# shellcheck source=/dev/null
. "$HOME/.local/share/../bin/env"
