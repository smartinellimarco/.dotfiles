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


TODO: lazygit lazydocker smartcat fzf zoxide xplr television algodekubernetes

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
  # https://github.com/helix-editor/helix/pull/13323, answer how zed does it
  # ty

  dockerfmt
  ruff
  gofumpt
  # mbake
  # just formatter?

  htmlq
  jq

  # httpyac?
  xh
  grpcurl
  websocat

  tree
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
