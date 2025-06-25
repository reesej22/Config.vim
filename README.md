Configuration File - `vimrc`

A cross-platform `.vimrc` designed for simplicity and functionality — no plugin managers or external dependencies required. This setup works out of the box on **Linux** and **Windows** (including gVim), and I us it as a drop in default configuration.

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

## ✅ Usage

To install:

```sh
# For Linux/Unix
cp vimrc ~/.vimrc

# For Windows (cmd)
copy vimrc %USERPROFILE%\_vimrc

