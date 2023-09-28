# Dotfiles

## Table of contents

<!--toc:start-->
- [Dotfiles](#dotfiles)
  - [Table of contents](#table-of-contents)
  - [Getting started](#getting-started)
    - [Requirements](#requirements)
    - [Installation](#installation)
  - [Backing up](#backing-up)
  - [Troubleshooting](#troubleshooting)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and run post-installation steps.

Use brew to setup packages, only if they are not already present in the system
```bash
brew tap homebrew/cask-fonts
for package in git gh zsh antidote yadm gcc node make ripgrep neovim gpg fd; do
  if ! command -v $package &> /dev/null
  then
    brew install $package
  fi
done
brew install --cask kitty font-symbols-only-nerd-font
```

If needed, change shell then logout/login
```bash
chsh -s $(which zsh)
```

### Installation

1. Clone dotfiles using yadm

```bash
yadm clone https://github.com/smartinellimarco/.dotfiles
yadm decrypt
```

2. Restart shell and kitty

## Backing up
```bash
yadm encrypt
yadm add -u
yadm commit -m "Backup"
yadm push
```

## Troubleshooting

<details> 
  <summary> Bootstrap zsh file </summary>
<br>

Any initialization commands not intended to backed up can be placed in '.zsh_bootstrap'.

This file is automatically sourced in interactive and login shells.
</details>

<details>
  <summary> Open windows at the center of the screen </summary>
<br>

For Ubuntu and Gnome:

```bash
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

```bash
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

