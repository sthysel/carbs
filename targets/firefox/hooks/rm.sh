#!/bin/sh
# Remove Firefox suspend/resume service

arch() {
    sudo systemctl disable firefox-suspend.service 2>/dev/null || true
    sudo rm -f /etc/systemd/system/firefox-suspend.service
    sudo systemctl daemon-reload
}
