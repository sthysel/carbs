#!/bin/sh
# Install MCP servers for use by LLM agents

log_info "Installing MCP servers..."

arch() {
    yay_install nodejs npm
}

generic() {
    # markitdown-mcp: converts documents to markdown
    has_or_exit uv
    uv tool install --upgrade 'markitdown-mcp[all]'

    # context7: up-to-date library documentation for LLMs
    has_or_exit npx
    npm_install @upstash/context7-mcp
}
