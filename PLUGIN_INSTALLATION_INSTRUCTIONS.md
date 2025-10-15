# Instructions to Fix auto-session Plugin

The auto-session plugin is configured in your setup, but it needs to be installed via Lazy's UI.

## Steps to Install the Plugin:

1. Open Neovim normally:
   ```
   nvim
   ```

2. Run the Lazy UI command:
   ```
   :Lazy
   ```

3. In the Lazy UI, you should see a list of plugins including `rmagatti/auto-session`.

4. If the plugin shows as needing to be installed (usually with an "I" or install option), press the install key (often 'I' or 'X' depending on your Lazy configuration).

5. Wait for the installation to complete.

6. Close and reopen Neovim to load the new plugin.

## Alternative Method:

If you prefer to install all plugins at once:

1. Open Neovim:
   ```
   nvim
   ```

2. Run:
   ```
   :Lazy sync
   ```

This will install all missing plugins.

## After Installation:

Once installed, you can verify that the plugin works by running:
```
:checkhealth
```

You should no longer see the "module auto-session not found" error.