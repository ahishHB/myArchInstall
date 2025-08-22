-- from LLM
return {
  "neovim/nvim-lspconfig",  -- LSP configuration plugin
  config = function()
    -- Keybindings when LSP attaches to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
      callback = function(event)
        local opts = {buffer = event.buf}
        
        -- LSP Keybindings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)          -- Go to definition
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                -- Hover for documentation
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)  -- Workspace symbol search
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)     -- Show diagnostics
        vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_next, opts)               -- Next diagnostic
        vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_prev, opts)               -- Previous diagnostic
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)       -- Code actions
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)       -- Find references
        vim.keymap.set('n', '<leader>re', vim.lsp.buf.rename, opts)           -- Rename symbol
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)          -- Signature help in insert mode
      end,
    })
  end
}
