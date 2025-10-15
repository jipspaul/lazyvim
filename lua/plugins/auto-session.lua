return {
  "rmagatti/auto-session",
  enabled = true,
  lazy = false, -- load on startup
  priority = 100, -- high priority to load early
  config = function()
    local opts = {
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- Additional configuration options
      session_lens = {
        load_on_startup = false,
        load_on_setup = false,
        skip_sessions_without_focused_file = true,
      },
    }
    require("auto-session").setup(opts)
  end,
}