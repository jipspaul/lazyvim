return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    config = function()
      require("CopilotChat").setup({
        debug = false,
        model = "gpt-4",
        temperature = 0.1,
        show_help = true,
        show_folds = true,
        show_system_prompt = false,
        auto_insert_mode = false,
        clear_chat_on_new_prompt = false,
        answer_header = "  Copilot ",
        error_header = "  Error ",
        separator = "───",
        chat_autocomplete = true,
        chat_context = "buffers",
        history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
        question_header = "  User ",
      })

      -- Keymaps
      vim.keymap.set({ "n", "v" }, "<leader>ccb", function()
        require("CopilotChat").open()
      end, { desc = "CopilotChat - Toggle chat buffer" })

      vim.keymap.set({ "n", "v" }, "<leader>cce", function()
        local input = vim.fn.input("Prompt: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end, { desc = "CopilotChat - Open chat with custom prompt" })

      vim.keymap.set("v", "<leader>ccx", function()
        require("CopilotChat").ask(vim.fn.input("Prompt: "), { selection = true })
      end, { desc = "CopilotChat - Ask about selection" })

      vim.keymap.set("v", "<leader>ccf", function()
        require("CopilotChat").ask("Fix the selected code", { selection = true })
      end, { desc = "CopilotChat - Fix selected code" })

      vim.keymap.set("v", "<leader>ccd", function()
        require("CopilotChat").ask("Explain the selected code", { selection = true })
      end, { desc = "CopilotChat - Explain selected code" })

      vim.keymap.set("v", "<leader>cct", function()
        require("CopilotChat").ask("Write tests for the selected code", { selection = true })
      end, { desc = "CopilotChat - Write tests for selection" })

      vim.keymap.set("v", "<leader>ccr", function()
        require("CopilotChat").ask("Review the selected code", { selection = true })
      end, { desc = "CopilotChat - Review selected code" })

      vim.keymap.set("v", "<leader>cco", function()
        require("CopilotChat").ask("Optimize the selected code", { selection = true })
      end, { desc = "CopilotChat - Optimize selected code" })
    end,
  },
}