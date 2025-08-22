# 🚀 Neovim Configuration

A modern, minimalist Neovim configuration built with [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## ✨ Features

- **Theme**: Catppuccin colorscheme for a beautiful, consistent look
- **LSP Support**: Full Language Server Protocol integration with autocompletion
- **Fuzzy Finding**: Telescope for powerful file and text searching
- **Git Integration**: LazyGit integration and git-blame for version control
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
- `<leader>e` - Toggle file explorer
- `<C-h/j/k/l>` - Navigate between tmux panes/vim windows

### File Operations
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)

### Git Operations
- `<leader>lg` - Open LazyGit
- Git blame information displayed inline

### Docker
- `<leader>ld` - Toggle LazyDocker

### Editing Enhancements
- `U` - Redo (better than default Ctrl-R)
- `<leader>d` - Delete without yanking
- `<` / `>` (in visual mode) - Indent left/right and reselect
- Auto-highlight yanked text

## 📁 Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration entry point
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── vim-options.lua        # Core Vim settings and keymaps
│   └── plugins/               # Plugin configurations
│       ├── autopairs.lua      # Auto-closing brackets/quotes
│       ├── completions.lua    # Autocompletion setup
│       ├── diagnostics.lua    # LSP diagnostics configuration
│       ├── git-blame.lua      # Git blame integration
│       ├── lazydocker.lua     # Docker management
│       ├── lazygit.lua        # Git interface
│       ├── lsp-config.lua     # Language server setup
│       ├── lualine.lua        # Status line
│       ├── render-markdown.lua # Markdown rendering
│       ├── telescope.lua      # Fuzzy finder
│       ├── theme.lua          # Color scheme
│       ├── tmux-navigator.lua # Tmux integration
│       └── treesitter.lua     # Syntax highlighting
└── README.md                  # This file
```

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
