<h3 align="center">
.dotfiles
</h3>

<p align="center">
  <img width="1470" alt="Screenshot 2023-09-28 at 19 21 07" src="https://github.com/smartinellimarco/.dotfiles/assets/15314838/6d2a4a96-88a6-4d7b-bd8f-f8c3c9d98341">
</p>

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
- [Keymaps](#keymaps)
- [Tips & Troubleshooting](#tips-troubleshooting)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and follow post-installation steps.

Use brew to setup packages, only if they are not already present in the system
```zsh
for package in git gh zsh antidote yadm gcc node make ripgrep neovim gpg fd; do
  if ! command -v $package &> /dev/null
  then
    brew install $package
  fi
done
```

Install kitty and nerd fonts:

- MacOS
  
  ```zsh
  brew tap homebrew/cask-fonts
  brew install --cask kitty font-symbols-only-nerd-font font-jetbrains-mono
  ```
- Linux
  
  Manually install the monospaced version of the [NerdFontsSymbolsOnly](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip) package.
  
  Install [kitty](https://sw.kovidgoyal.net/kitty/binary/#binary-install) binary and follow desktop integration instructions.

  Install [JetBrains Mono Font](https://github.com/JetBrains/JetBrainsMono#manual-installation) using the Linux script.

If needed, change default shell to zsh (requires user re-login)
```zsh
chsh -s $(which zsh)
```

### Installation

Clone the repository using yadm
```zsh
yadm clone https://github.com/smartinellimarco/.dotfiles
```

The first time you reopen the terminal, antidote will automatically setup all zsh plugins.

Neovim will do the same for lazy plugins, treesitter parsers and mason LSPs.

## Archive 

Fortunately, yadm offers an easy way of backing up and restoring sensitive configuration files. 

### Backup

Each file path must be specified in [_~/.config/yadm/encrypt_](https://github.com/smartinellimarco/.dotfiles/blob/master/.config/yadm/encrypt).

Then by running
```zsh
GPG_TTY=$TTY yadm encrypt
```
and filling the password prompt, an encrypted file in _~/.local/share/yadm/archive_ will be created with the contents of every listed file.

### Restore

Place the archive file in _~/.local/share/yadm/archive_ and run
```zsh
yadm decrypt
```
The files will be restored to their original locations.

## Bootstrap file

Any initialization commands not intended to be backed up in this repository, can be placed in _~/.zsh_bootstrap_.

This file is automatically sourced in interactive and login shells.

## Keymaps
TODO: update

Kitty

| keymap | description | OS |
|--------|-------------|----|
| cmd+t | Open new tab | MacOS |
| ctrl+shift+t | Open new tab | Linux - Windows |
| cmd+\<number> | Go to tab \<number> | MacOS |
| ctrl+\<number> | Go to tab \<number> | Linux - Windows |
| ctrl+tab | Next tab | Linux - Windows - MacOS |
| ctrl+shift+tab | Previous tab | Linux - Windows - MacOS |
| cmd+w | Close tab | MacOS |
| cmd+shift+w | Close tab | Linux - Windows - MacOS |
| cmd+q | Quit application | MacOS |
| cmd+shift+q | Quit application | Linux - Windows - MacOS |
| cmd+c | Copy to clipboard | MacOS |
| cmd+shift+c | Copy to clipboard | Linux - Windows - MacOS |
| cmd+v | Paste from clipboard | MacOS |
| cmd+shift+v | Paste from clipboard | Linux - Windows - MacOS |

Zsh

| keymap | description | source |
|--------|-------------|--------|
| z+\<dir> | Change directory to the most probable match of \<dir> | Plugin |
| ctrl+f | Accept autosuggestion (equivalent of pressing '→') | Native |
| ctrl+l | Clear screen | Native |
| ctrl+p | Select previous command | Native |
| ctrl+n | Select next command | Native |

Neovim

| keymap | description | source |
|--------|-------------|--------|
| \<leader>+e | Open find files picker | Telescope |
| \<leader>+f | Open fuzzy finder picker | Telescope |
| ctrl+p | Go back in the jumplist until the previous buffer is reached | Bufjump |
| ctrl+n | Go back in the jumplist until the next buffer is reached | Bufjump |
| gd | Go to definition | LSP |
| gl | Open diagnostics picker | LSP - Telescope |
| K | Hover | LSP |
| \<F2\> | Rename element | LSP |
| \<F4\> | Open available code actions | LSP |

The rest is just pure stock neovim.

## Tips & Troubleshooting
<details>
  <summary> Open windows at the center of the screen </summary>
<br>

For Ubuntu and Gnome:

```zsh
gsettings set org.gnome.mutter center-new-windows true 
```
</details>

<details>
  <summary> Suggested build environment for pyenv </summary>
<br>

Sometimes compiling (pyenv install) fails because of unmet system dependencies.

Follow these [instructions](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) for a sane build environment.
</details>

<details>
  <summary> Setting compiler flags for OpenSSL </summary>
<br>

The Python compiler might not be able to find OpenSSL if it's installed with Homebrew.

The following command sets the corresponding flags with the correct installation path.

```zsh
LDFLAGS="-Wl,-rpath,$(brew --prefix openssl)/lib" \
CPPFLAGS="-I$(brew --prefix openssl)/include" \
CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)" \
pyenv install -v <PYTHON_VERSION>
```
</details>

<details>
  <summary> Shared clipboard doesn't work in neovim </summary>
<br>

In Ubuntu, this is most likely because of [xclip](https://linux.die.net/man/1/xclip) missing.

</details>
