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

  just

  uv
  rustup
  go
  node
  mactex
  hashicorp/tap/terraform

  jdtls
  lua-language-server
  docker-language-server
  bash-language-server
  typescript-language-server
  vscode-langservers-extracted
  yaml-language-server
  terraform-ls
  marksman
  gopls
  tombi
  terror/tap/just-lsp
  texlab
  ty
  ruff
  rumdl
  # TODO: commit-lsp

  dockerfmt # TODO: unused
  gofumpt # TODO: make gopls use this, remove if not required

  htmlq
  jq

  # TODO: yaak/nexus?
  iamb
  k9s
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

The first time you reopen the terminal, antidote will automatically setup all
zsh plugins.

## Bootstrap file

Initialization commands not intended for backup in this repository can be placed
in `~/.zsh_bootstrap`, which is automatically sourced.
