## Table of contents

<!--toc:start-->
- [Table of contents](#table-of-contents)
- [Getting started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
- [Bootstrap file](#bootstrap-file)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and skip post-installation steps.

Most of these dependencies are available by default on macOS (via Xcode command line tools).

This script only installs the missing ones.

| Tool | Dependencies |
|------|--------------|
| .dotfiles | zsh, gh, antidote, yadm, helix, mise, ghostty |

# TODO: nix

```zsh
dependencies=(
  gh
  antidote
  yadm
  helix
  mise
  ghostty
)

for package in "${dependencies[@]}"; do
  brew install $package
done
```

### Installation

Clone the repository using yadm
```zsh
yadm clone https://github.com/smartinellimarco/.dotfiles
```

The first time you reopen the terminal, antidote will automatically setup all zsh plugins.

## Bootstrap file

Initialization commands not intended for backup in this repository can be placed in `~/.zsh_bootstrap`, which is automatically sourced.
