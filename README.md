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

Run:

```zsh
dependencies=(
  gh
  antidote
  yadm

  ghostty

  helix

  container

  docker
  docker-compose
  docker-buildx
  docker-credential-helper
  colima

  awscli
  kubectl
  hashicorp/tap/terraform

  just

  uv
  rustup
  go
  node

  lua-language-server
  # https://github.com/texel-sensei/commit-lsp
  # TODO: replace with official when the formulae gets fixed
  dockerfile-language-server
  bash-language-server
  typescript-language-server
  vscode-langservers-extracted
  yaml-language-server
  terraform-ls
  marksman
  gopls
  tombi
  # just-lsp
  # ty
  # https://github.com/helix-editor/helix/wiki/Language-Server-Configurations add more from here

  dockerfmt
  ruff
  gofumpt
  # mbake
  # just formatter?

  htmlq
  jq

  # httpyac?
  # yaak?
  xh
  grpcurl
  websocat
  trippy

  pastel

  tree

  lazygit
  lazydocker
  # smartcat
  # fzf?
  # nucleo?
  # zoxide?
  # television
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
