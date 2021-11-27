# wally.nvim
Neovim colorscheme based on pywal

## ⚡️ Requirements
- [Neovim](https://neovim.io/) >= 0.5.0
- [pywal](https://github.com/dylanaraps/pywal)

## 📦 Installation
Install the theme with your preferred package manager:
[packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use({
   "atalazer/wally.nvim",
   run = "./setup.sh",
   setup = function()
      YOUR_CONFIGURATION_SETUP
   end,
   config = [[require("wally").colorscheme()]]
})
```

## 🚀 Usage
Enable the colorscheme:

```vim
" Vim Script
colorscheme wally
```

```lua
-- Lua
vim.cmd[[colorscheme wally]]
```

## ⚙️ Configuration
> ❗️ configuration needs to be set **BEFORE** loading the colorscheme

| Option                    | Default        | Description                                                                             |
|---------------------------|----------------|-----------------------------------------------------------------------------------------|
| wally_wal_dir             | `~/.cache/wal` | Path to dir that contain generated colorscheme by pywal & **MUST** contain `colors.lua` |
| wally_italic_comments     | `false`        | Make comments italic                                                                    |
| wally_italic_keywords     | `true`         | Make keywords italic                                                                    |
| wally_italic_functions    | `true`         | Make functions italic                                                                   |
| wally_italic_variables    | `false`        | Make variables and identifiers italic                                                   |
| wally_dark_sidebar        | `true`         | Sidebar like windows like `NvimTree` get a darker background                            |
| wally_dark_float          | `true`         | Float windows like the lsp diagnostics windows get a darker background.                 |
| wally_transparent         | `false`        | Enable this to disable setting the background color                                     |
| wally_transparent_sidebar | `false`        | Sidebar like windows like `NvimTree` get a transparent background                       |
| wally_sidebars            | `{}`           | Set a darker background on sidebar-like windows.                                        |

```vim
" Example config in VimScript
let g:wally_wal_dir = "~/.cache/wal"
let g:wally_italic_functions = 1
let g:wally_sidebars =  [ "qf", "vista_kind", "terminal" "Nvimtree" "Trouble", "packer", ]

" Load the colorscheme
colorscheme wally
```

```lua
-- Example config in Lua
vim.g.wally_wal_dir = "~/.cache/wal"
vim.g.wally_italic_functions = true
vim.g.wally_sidebars = { "qf", "vista_kind", "terminal", "Nvimtree", "Trouble", "packer", }

-- Load the colorscheme
require("wally").colorscheme()
```

## Credits
- [dylanaraps/wal.vim](https://github.com/dylanaraps/wal.vim)
- [nekonako/xresources-nvim](https://github.com/nekonako/xresources-nvim)
- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
