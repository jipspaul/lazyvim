-- Debug Adapter Protocol (DAP) configuration for LazyVim
return {
  -- Mason DAP integration - Install debug adapters
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        -- Install common debug adapters
        "python",
        "codelldb",
        "node2",
        "chrome",
      },
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
    end,
  },

  -- Main DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")

      -- Set up DAP signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "DiagnosticWarn" })

      -- Add basic Lua adapter configuration for nvim-lua
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      -- Manual Dart/Flutter adapter configuration
      dap.adapters.dart = {
        type = "executable",
        command = "/Users/jeanpauljacquot/.puro/envs/default/flutter/bin/dart",
        args = { "debug_adapter" },
      }
      
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Current Dart File",
          dartSdkPath = "/Users/jeanpauljacquot/.puro/envs/default/flutter/bin/cache/dart-sdk/",
          program = "${file}",
          cwd = "${workspaceFolder}",
          args = {},
        },
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter App (lib/main.dart)",
          dartSdkPath = "/Users/jeanpauljacquot/.puro/envs/default/flutter/bin/cache/dart-sdk/",
          flutterSdkPath = "/Users/jeanpauljacquot/.puro/envs/default/flutter/",
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
          args = {},
        },
        {
          type = "dart",
          request = "attach",
          name = "Attach to Dart Process",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },

  -- UI for DAP with nvim-dap-view
  {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dap-view").toggle() end, desc = "Toggle DAP View" },
      { "<leader>de", function() require("dap-view").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      require("dap-view").setup(opts)
    end,
  },

  -- Original nvim-dap-ui (kept as fallback/alternative)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    enabled = false, -- Disabled in favor of nvim-dap-view
    keys = {
      { "<leader>dU", function() require("dapui").toggle({}) end, desc = "Dap UI (Classic)" },
    },
    opts = {
      expand_lines = true,
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.35 },
            { id = "breakpoints", size = 0.15 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "right",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.40 },
            { id = "console", size = 0.60 },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      
      -- Automatically open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- Virtual text for debugging
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      virt_text_pos = "eol",
    },
  },

  -- DAP Python integration
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", "jay-babu/mason-nvim-dap.nvim" },
    ft = "python",
    config = function()
      -- Wait for mason-nvim-dap to install debugpy
      vim.defer_fn(function()
        local ok, mason_registry = pcall(require, "mason-registry")
        if ok and mason_registry.is_installed("debugpy") then
          local debugpy_path = mason_registry.get_package("debugpy"):get_install_path()
          require("dap-python").setup(debugpy_path .. "/venv/bin/python")
        else
          -- Fallback to system python with debugpy
          vim.notify("debugpy not found via mason, using system python", vim.log.levels.WARN)
          require("dap-python").setup("python3")
        end
      end, 100)
    end,
  },

  -- DAP JavaScript/TypeScript integration
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      local dap = require("dap")
      
      -- Use Mason's js-debug-adapter if available
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
      local use_mason = vim.fn.isdirectory(mason_path) == 1
      
      if use_mason then
        require("dap-vscode-js").setup({
          node_path = "node",
          debugger_path = mason_path,
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        })
      else
        -- Manual setup for node debugging without vscode-js-debug
        dap.adapters.node2 = {
          type = "executable",
          command = "node",
          args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
        }
      end

      -- Configurations for JavaScript/TypeScript
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {}
        end
        
        vim.list_extend(dap.configurations[language], {
          {
            type = use_mason and "pwa-node" or "node2",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },
          {
            type = use_mason and "pwa-node" or "node2",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
          },
        })
      end
    end,
  },

  -- Lua debugging support
  {
    "jbyuki/one-small-step-for-vimkind",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      { "<leader>dL", function() require("osv").launch({ port = 8086 }) end, desc = "Launch Lua Debugger Server" },
    },
  },

  -- Flutter/Dart debugging is handled by flutter-tools.nvim
  -- See lua/plugins/flutter.lua for configuration
}
