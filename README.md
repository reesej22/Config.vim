Configuration File - `vimrc`

A cross-platform `.vimrc` designed for simplicity and functionality — no plugin managers or external dependencies required. This setup works out of the box on **Linux** and **Windows** (including gVim), and is ideal for users who want a clean, efficient editing environment without relying on third-party packages.

---

## 📜 Features

- UTF-8 support for consistent encoding
- Optional Nerd Font UI enhancements
- Status line with helpful info (filetype, line/col, modified flag)
- Line numbers and relative line numbers
- Smart tab and indent settings
- Persistent undo and backups
- Intelligent case-aware searching
- Visual improvements to whitespace and folds
- Filetype detection and plugin/indent activation
- Portable between Linux and Windows (uses platform checks)

---

## 🔧 Notable Settings

| Setting           | Description                                     |
|-------------------|-------------------------------------------------|
| `runtime! defaults.vim` | Loads Vim's sensible defaults |
| `let has_nerd_font = v:true` | Enables enhanced UI symbols |
| `set number relativenumber` | Shows both absolute and relative line numbers |
| `set tabstop=4 shiftwidth=4 expandtab` | Consistent 4-space soft tabs |
| `set ignorecase smartcase` | Smart case-sensitive search |
| `set wildmenu wildmode=list:longest` | Improved command completion UI |
| `set list listchars=...` | Highlights tabs, trailing spaces, etc. |
| `set foldmethod=indent` | Code folding based on indentation |

---

## 🪄 Special Behavior

- **Nerd Font Mode**
  If `has_nerd_font` is set to `true`, additional visual enhancements are enabled using Unicode glyphs. These appear in:
  - Statusline (e.g. lock icon when file is readonly)
  - `listchars` and `fillchars` (e.g. fancy arrows and blocks)

- **Cross-Platform Compatibility**
  Detects Windows vs Unix to:
  - Set shell options
  - Define file paths and backup behavior
  - Use `ctags.exe` on Windows

- **Lightweight Design**
  No plugin manager required. If additional plugins are desired, they can be added via native `packadd!` or Git into `~/.vim/pack/...`.

---

## ✅ Usage

To install:

```sh
# For Linux/Unix
cp vimrc ~/.vimrc

# For Windows (cmd)
copy vimrc %USERPROFILE%\_vimrc

