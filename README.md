# Neovim Configuration (`nvim_conf`)

A personal, modern Neovim configuration built with Lua, featuring fuzzy file finding, full LSP IntelliSense, autocomplete dropdowns, and TokyoNight styling.

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

### 2. Autocompletion & IntelliSense (Dropdown Menu)

The dropdown menu automatically appears while typing. You can also interact with it using:

| Shortcut | Mode | Action |
| :--- | :---: | :--- |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd> | Insert | Manually trigger autocomplete dropdown / parameter hints |
| <kbd>Tab</kbd> | Insert | Select next item / expand snippet |
| <kbd>Shift</kbd> + <kbd>Tab</kbd> | Insert | Select previous item / jump back in snippet |
| <kbd>Enter</kbd> | Insert | Confirm and insert selected completion |
| <kbd>Ctrl</kbd> + <kbd>d</kbd> | Insert | Scroll documentation popup **down** |
| <kbd>Ctrl</kbd> + <kbd>u</kbd> | Insert | Scroll documentation popup **up** |
| <kbd>Ctrl</kbd> + <kbd>e</kbd> | Insert | Abort / close completion menu |

---

### 3. LSP & Code Intelligence (Hover & Navigation)

Available whenever a language server is attached to a file (Python, Rust, PowerShell, Go, etc.):

| Shortcut | Mode | Action |
| :--- | :---: | :--- |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd> or <kbd>K</kbd> | Normal | **Hover info**: Show class/function signature, types, and docstrings |
| <kbd>g</kbd><kbd>d</kbd> | Normal | **Go to Definition** |
| <kbd>g</kbd><kbd>D</kbd> | Normal | **Go to Declaration** |
| <kbd>g</kbd><kbd>i</kbd> | Normal | **Go to Implementation** |
| <kbd>g</kbd><kbd>r</kbd> | Normal | **Find References** across the project |
| `<leader>` + <kbd>r</kbd><kbd>n</kbd> | Normal | **Rename symbol** across all files |
| <kbd>[</kbd><kbd>d</kbd> | Normal | Jump to **previous diagnostic** (error/warning) |
| <kbd>]</kbd><kbd>d</kbd> | Normal | Jump to **next diagnostic** (error/warning) |

---

### 4. General & Navigation

| Shortcut | Mode | Action |
| :--- | :---: | :--- |
| <kbd>F3</kbd> | Normal / Visual | Open file directory explorer (`:Explore`) |
| <kbd>F4</kbd> | Normal / Visual / Terminal | **Toggle terminal split** (open/focus PowerShell 7, or jump back to editor) |
| <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>w</kbd> | Normal | Cycle to next window split |
| <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>p</kbd> | Normal | Jump to previous accessed window split |

---

## Language Servers & Tools

Managed via [`mason.nvim`](https://github.com/williamboman/mason.nvim):

* **Python**: `pyright`
* **Rust**: `rust-analyzer`
* **PowerShell**: `powershell-editor-services`
* **Go**: `gopls` *(install Go on system, then run `:MasonInstall gopls`)*

### Helpful Commands:
* `:Mason` — Visual dashboard to install, update, or remove language servers
* `:PlugInstall` — Install newly added plugins from `init.lua`
