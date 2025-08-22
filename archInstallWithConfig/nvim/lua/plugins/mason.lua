
return {
  {
    "williamboman/mason.nvim", -- standalone Mason plugin
    build = ":MasonUpdate",    -- optional, ensures updates on install
    config = function()
      require("mason").setup()
	  require("mason-nvim-dap").setup({
  ensure_installed = { "cppdbg", "python" }, -- optional, for auto-installs
})
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim", -- helper to bridge Mason and lspconfig
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
          clangd = function()
            require("lspconfig").clangd.setup({

			  -- Set the root directory to the location of the Makefile
			  root_dir = require('lspconfig').util.root_pattern('Makefile', '.git'),

              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = {
                clangd = {
                  compilationDatabasePath = "build",
                  diagnostics = { enable = true },
                },
              },
            })
          end,
        }
      })
    end,
  }
}
