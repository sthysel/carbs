-- Language-specific plugin configuration for Python, Lua, and Rust

return {
  -- Treesitter: ensure language parsers are installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "lua",
        "rust",
        "toml", -- Cargo.toml
      })
    end,
  },

  -- Mason: ensure language tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Lua
        "stylua",
        -- Python (prefer uv-installed tools, these are fallbacks)
        "debugpy",
        -- Rust
        "codelldb", -- Rust debugger
      })
    end,
  },

  -- Python: prefer basedpyright over pyright
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},
        pyright = { enabled = false },
      },
    },
  },
}
