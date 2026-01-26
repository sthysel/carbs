-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- OSC 52 clipboard configuration for SSH sessions
if os.getenv("SSH_TTY") then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
end

-- Enable both clipboard registers:
-- unnamedplus = CLIPBOARD (Ctrl+C/V, "+)
-- unnamed = PRIMARY (highlight/middle-click, "*)
-- Yanks go to both; mouse selection in Kitty uses PRIMARY directly
vim.opt.clipboard = "unnamed,unnamedplus"
