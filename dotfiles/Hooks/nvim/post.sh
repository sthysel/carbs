#!/bin/bash
# Install/update lazy.nvim plugins after deploying nvim config
echo "Installing nvim plugins..."
nvim --headless "+Lazy! sync" +qa
echo "Neovim setup complete!"
