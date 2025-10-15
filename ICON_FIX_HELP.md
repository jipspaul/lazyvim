# Missing Icons Fix

If you're seeing missing icons in your LazyVim setup, this is most likely due to not having a Nerd Font configured in your terminal.

## Solution

1. Install a Nerd Font (if not already done):
   ```bash
   # Using Homebrew (macOS)
   brew tap homebrew/cask-fonts
   brew install --cask font-jetbrains-mono-nerd-font
   # Or another font like:
   # brew install --cask font-fira-code-nerd-font
   ```

2. Configure your terminal to use a Nerd Font:
   - iTerm2: Preferences → Profiles → Text → Change Font to "JetBrains Mono Nerd Font" (or similar)
   - Terminal.app: Preferences → Profiles → Text → Font → Choose a Nerd Font
   - Other terminals: Look for font settings and select a Nerd Font

3. Restart your terminal completely

4. Open Neovim again, and the icons should now be visible

The icons are provided by the `mini.icons` plugin which is already configured in your LazyVim setup. This plugin requires Nerd Fonts to display the special icon characters correctly.