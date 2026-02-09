#!/bin/sh
# Enable the Firefox suspend/resume freeze service

arch() {
    systemctl --user daemon-reload
    systemctl --user enable firefox-suspend.service
}
