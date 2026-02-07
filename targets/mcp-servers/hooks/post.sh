#!/bin/sh
# Register MCP servers with Claude Code

generic() {
    if has claude; then
        log_info "Registering MCP servers with Claude Code..."
        claude mcp add -s user markitdown -- markitdown-mcp
        claude mcp add -s user context7 -- npx -y @upstash/context7-mcp
    else
        log_warn "claude CLI not found, skipping MCP registration"
    fi
}
