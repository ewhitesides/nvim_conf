# Neovim Configuration (`nvim_conf`)

A personal, modern Neovim configuration built with Lua, featuring fuzzy file finding, Git change indicators, and TokyoNight styling.

---

## Plugins

Managed via [`vim-plug`](https://github.com/junegunn/vim-plug):

| Plugin | Purpose |
| :--- | :--- |
| [`vim-airline/vim-airline`](https://github.com/vim-airline/vim-airline) | Status bar |
| [`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [`airblade/vim-gitgutter`](https://github.com/airblade/vim-gitgutter) | Git diff signs in the gutter |
| [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (Telescope dependency) |
| [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy file finder |

### Helpful Commands

* `:PlugInstall` — Install newly added plugins from `init.lua`
* `:PlugUpdate` — Update installed plugins
* `:PlugClean` — Remove unused plugins

---

## Keybindings & Shortcuts Reference

### 1. File Search (Ctrl+P / Telescope)

| Shortcut | Mode | Action |
| :--- | :---: | :--- |
| <kbd>Ctrl</kbd> + <kbd>P</kbd> | Normal | Open fuzzy file search (`Telescope find_files`) |
| <kbd>Enter</kbd> | Picker | Open the selected file |
| <kbd>Ctrl</kbd> + <kbd>v</kbd> | Picker | Open selected file in a **vertical split** |
| <kbd>Ctrl</kbd> + <kbd>x</kbd> | Picker | Open selected file in a **horizontal split** |
| <kbd>Ctrl</kbd> + <kbd>n</kbd> / <kbd>↓</kbd> | Picker | Move to next search result |
| <kbd>Ctrl</kbd> + <kbd>p</kbd> / <kbd>↑</kbd> | Picker | Move to previous search result |
| <kbd>Esc</kbd> | Picker | Close the file search picker |

---

### 2. General & Navigation

| Shortcut | Mode | Action |
| :--- | :---: | :--- |
| <kbd>F3</kbd> | Normal / Visual | Open file directory explorer (`:Explore`) |
| <kbd>F4</kbd> | Normal / Visual | **Toggle terminal split** (open/focus PowerShell 7, or jump back to editor) |
| <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>w</kbd> | Normal | Cycle to next window split |
| <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>p</kbd> | Normal | Jump to previously accessed window split |

---

## Editor Settings

| Setting | Value | Description |
| :--- | :--- | :--- |
| `number` | `true` | Line numbers |
| `ruler` | `true` | Show column number |
| `splitbelow` / `splitright` | `true` | New splits open below / to the right |
| `mouse` | `""` | Mouse disabled |
| `expandtab` | `true` | Tabs → spaces |
| `shiftwidth` / `softtabstop` | `2` | 2-space indentation |
| `ignorecase` + `incsearch` | `true` | Case-insensitive incremental search |
| Cursor blink | 500ms on/off | Block cursor blinks in normal & insert mode |
| Trailing whitespace | Auto-removed | Stripped on every `:w` via `BufWritePre` |
| netrw banner | Disabled | Cleaner `:Explore` view (tree style) |
