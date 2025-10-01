# 🚀 Neovim Configuration

A modern, minimalist Neovim configuration built with [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## ✨ Features

- **Theme**: Catppuccin colorscheme for a beautiful, consistent look
- **LSP Support**: Full Language Server Protocol integration with autocompletion
- **File Explorer**: Oil.nvim for fast file navigation and editing
- **Fuzzy Finding**: Telescope for powerful file and text searching
- **Git Integration**: LazyGit integration for version control
- **Docker Support**: LazyDocker integration for container management
- **Smart Navigation**: Tmux Navigator for seamless pane switching
- **Syntax Highlighting**: TreeSitter for enhanced code parsing
- **Auto-completion**: Smart completions and auto-pairs
- **Status Line**: Beautiful Lualine status bar
- **Markdown Rendering**: Enhanced markdown preview capabilities

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `Space`

### Core Navigation
- `<leader>e` - Open Oil file explorer (floating)
- `<C-h/j/k/l>` - Navigate between tmux panes/vim windows

### File Operations
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)

### Git Operations
- `<leader>lg` - Open LazyGit

### Docker
- `<leader>ld` - Toggle LazyDocker

### Editing Enhancements
- `U` - Redo (better than default Ctrl-R)
- `<leader>d` - Delete without yanking
- `<` / `>` (in visual mode) - Indent left/right and reselect
- Auto-highlight yanked text

## 🎨 Customization

### Adding New Plugins
Create a new file in `lua/plugins/` with your plugin configuration:

```lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin setup here
  end
}
```

### Modifying Settings
Edit `lua/vim-options.lua` to adjust core Vim settings and keymaps.

### Changing Theme
Modify `lua/plugins/theme.lua` to use a different colorscheme.
