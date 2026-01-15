#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Enabling ssh-agent user service..."
systemctl --user enable --now ssh-agent.service

echo "Configuring SSH to add keys to agent..."
add_line_to_file "AddKeysToAgent yes" "$HOME/.ssh/config"
