#!/bin/sh
# Enable the Firefox suspend/resume freeze service

arch() {
    # Clean up old user-level service (never worked - sleep.target not in user scope)
    systemctl --user disable firefox-suspend.service 2>/dev/null || true
    rm -f "$HOME/.config/systemd/user/firefox-suspend.service"
    systemctl --user daemon-reload 2>/dev/null || true

    # Enable system-level service (symlinked via ^etc config)
    sudo systemctl daemon-reload
    sudo systemctl enable firefox-suspend.service
}
