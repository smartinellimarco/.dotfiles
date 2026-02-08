# Table of contents

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

Run:

```zsh
brew bundle --file ~/Brewfile
brew services start colima
```

### Installation

Clone the repository using yadm

```zsh
yadm clone https://github.com/smartinellimarco/.dotfiles
```

The first time you reopen the terminal, antidote will automatically setup all
zsh plugins.

## Bootstrap file

Initialization commands not intended for backup in this repository can be placed
in `~/.zsh_bootstrap`, which is automatically sourced.
