## Table of contents

<!--toc:start-->
- [Table of contents](#table-of-contents)
- [Getting started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
- [Archive](#archive)
  - [Backup](#backup)
  - [Restore](#restore)
- [Bootstrap file](#bootstrap-file)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and skip post-installation steps.

Most of these dependencies are available by default on macOS (via Xcode command line tools).

This script only installs the missing ones.

| Tool | Dependencies |
|------|--------------|
| .dotfiles | zsh, gh, antidote, yadm, neovim, mise |
| yadm | openssl |
| mason.nvim | git, curl/wget, unzip, gtar/tar, gzip, bash, sh |
| lazy.nvim | git, luarocks |
| nvim-telescope | ripgrep, make, clang/gcc, fd |
| nvim-treesitter | tar, curl, ~~git~~, cc/gcc/clang/cl/zig |

```
TODO: add LSPs and formatters.
TODO: pin versions of some dependencies
TODO: delete mason, usar lspconfig
```

```zsh
dependencies=(
  luarocks
  ripgrep
  fd
  gh
  antidote
  yadm
  neovim
  openssl
)

cask_dependencies=(
  font-symbols-only-nerd-font
  font-jetbrains-mono
  kitty
)

for package in "${dependencies[@]}"; do
  if ! command -v $package &> /dev/null; then
    brew install $package
  fi
done

for cask in "${cask_dependencies[@]}"; do
  if ! brew list --cask $cask &>/dev/null; then
    brew install --cask $cask
  fi
done
```

### Installation

Clone the repository using yadm
```zsh
yadm clone https://github.com/smartinellimarco/.dotfiles
```

The first time you reopen the terminal, antidote will automatically setup all zsh plugins.

Neovim will do the same for lazy plugins, treesitter parsers and mason LSPs & Formatters.

## Archive 

### Backup

Each file path must be specified in [`~/.config/yadm/encrypt`](https://github.com/smartinellimarco/.dotfiles/blob/master/.config/yadm/encrypt).

Then by running
```zsh
GPG_TTY=$TTY yadm encrypt
```
and filling the password prompt, an encrypted file in `~/.local/share/yadm/archive` will be created with the contents of every listed file.

### Restore

Place the archive file in `~/.local/share/yadm/archive` and run
```zsh
yadm decrypt
```
The files will be restored to their original locations.

## Bootstrap file

Initialization commands not intended for backup in this repository can be placed in `~/.zsh_bootstrap`, which is automatically sourced.
