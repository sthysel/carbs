#!/bin/bash
# Bootstrap lazy.nvim and install/sync plugins

echo "🚀 Bootstrapping LazyVim..."

NVIM_CONFIG="$HOME/.config/nvim"
LOCK_FILE="$NVIM_CONFIG/lazy-lock.json"

# Check for backup from pre.sh (same PID won't work across hooks, check for any recent backup)
LOCK_BACKUP=$(find /tmp -maxdepth 1 -name "lazy-lock.json.backup.*" -mmin -5 2>/dev/null | head -1)

if [ -n "$LOCK_BACKUP" ] && [ -f "$LOCK_BACKUP" ]; then
    # Restore backed up lock file to preserve local plugin versions
    echo "📦 Restoring local plugin versions..."
    cp "$LOCK_BACKUP" "$LOCK_FILE"
    rm -f "$LOCK_BACKUP" /tmp/lazy-lock-backup-path.*
    echo "✓ Plugin versions preserved (skipping sync to avoid changes)"
elif [ -f "$LOCK_FILE" ]; then
    # Lock file exists (maybe from target dir), preserve it
    echo "✓ Existing lazy-lock.json found, preserving plugin versions"
else
    # Fresh install - sync plugins to get latest versions
    echo "📦 Fresh install, syncing plugins..."
    nvim --headless "+Lazy! sync" +qa
    echo "✓ Plugins installed"
fi

echo "✓ LazyVim ready! Run 'nvim' to start."
