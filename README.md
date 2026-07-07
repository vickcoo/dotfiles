## Quick Start

1. **Install** `stow` via **Homebrew**
```bash
brew install stow
```

2. **Clone** this repository into your home directory(`~`)
```bash
git clone https://github.com/vickcoo/dotfiles
```

3. **Navigate** to the repository directory
```bash
cd ~/dotfiles
```

4. **Run** the command to **link** your dotfiles
```bash
stow .
```

## New Machine Setup (macOS)

Prerequisites for a fresh Mac. Neovim plugins install themselves on first launch — you only need the external tools below.

### Install with Homebrew

```bash
# Core
brew install neovim ripgrep fd

# Formatters / Linters (Swift)
brew install swiftformat swiftlint

# LSP servers
brew install lua-language-server beancount-language-server

# Java: JDK + jdtls language server (Maven projects)
brew install openjdk maven jdtls

# A Nerd Font (for icons), e.g.
brew install --cask font-jetbrains-mono-nerd-font
```

### LSP servers needing Node / Xcode

```bash
# Node-based servers
brew install node
npm install -g pyright typescript-language-server vim-language-server

# Swift server (sourcekit-lsp) ships with Xcode
xcode-select --install
```

> Tip: instead of installing each LSP server by hand, open Neovim and run `:Mason` to install them from a menu.

## Keymaps

Leader key is `<Space>`. `jk` exits insert mode.

### Files & Search (Telescope)
| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<C-p>` | Find git-tracked files |
| `<leader>fw` | Live grep (search as you type) |
| `<leader>fs` | Grep a prompted string |
| `<leader>fb` | List open buffers |
| `<leader>fg` | Changed files (git status) |
| `<leader>fh` | Search help |
| `<leader><leader>` | List all keymaps |

### File Explorer
| Key | Action |
| --- | --- |
| `<leader>n` | Toggle file tree (nvim-tree) |
| `-` | Open parent directory (oil) |

### LSP
| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Show references |
| `gI` | Go to implementation |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format buffer |
| `[d` / `]d` | Prev / next diagnostic |

### Diagnostics List (Trouble)
| Key | Action |
| --- | --- |
| `<leader>xx` | Diagnostics (project) |
| `<leader>xX` | Diagnostics (current buffer) |
| `<leader>xs` | Document symbols |

### Git (Gitsigns / Fugitive)
| Key | Action |
| --- | --- |
| `<leader>gs` | Git status window (fugitive) |
| `]c` / `[c` | Next / prev hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>tb` | Toggle inline blame |

### Harpoon (quick file marks)
| Key | Action |
| --- | --- |
| `<leader>a` | Mark current file |
| `<leader>e` | Toggle Harpoon menu |
| `<leader>h/j/k/l` | Jump to mark 1/2/3/4 |

### Misc
| Key | Action |
| --- | --- |
| `<leader>u` | Toggle undo tree |
| `<leader>y` | Yank to system clipboard |
| `<C-d>` / `<C-u>` | Half-page scroll (centered) |
