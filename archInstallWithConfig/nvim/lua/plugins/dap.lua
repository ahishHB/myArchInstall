-- this is made by llm
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio", -- Required by dap-ui
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- UI setup
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Virtual text
    require("nvim-dap-virtual-text").setup()

    -- Get the full path to codelldb adapter from Mason
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
    local codelldb_path = mason_path .. "adapter/codelldb"

    -- Codelldb adapter setup
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      }
    }

    -- C++ config using codelldb
    dap.configurations.cpp = {
      {
        name = "Launch C++",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    -- Also apply to C
    dap.configurations.c = dap.configurations.cpp

    -- Python (debugpy)
    dap.adapters.python = {
      type = "executable",
      command = "/usr/bin/python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch Python file",
        program = "${file}",
        pythonPath = function()
          return "/usr/bin/python"
        end,
      },
    }

    -- Optional keymaps
    vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
    vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
    vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
    vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
    vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end)
    vim.keymap.set("n", "<Leader>B", function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)
  end,
}

