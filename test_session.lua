-- Test script to verify auto-session plugin
local success, auto_session = pcall(require, "auto-session")
if success then
    print("auto-session plugin loaded successfully")
    auto_session.setup({
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
    print("auto-session plugin configured successfully")
else
    print("Failed to load auto-session plugin")
end