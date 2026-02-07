#!/bin/sh
# Install Claude Code CLI

linux() {
    log_info "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
}
