# Table of contents

<!--toc:start-->

- [Table of contents](#table-of-contents)
  - [Getting started](#getting-started)
    - [Requirements](#requirements)
    - [Installation](#installation)
  - [Bootstrap file](#bootstrap-file)
  - [Colima](#colima)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and skip post-installation steps.

Run:

```zsh
# Install dependencies
brew bundle --file https://github.com/smartinellimarco/.dotfiles/raw/master/Brewfile
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

## Colima

Spawn Colima VM:

MacOS:

```zsh
colima start --cpus 4 --memory 8 --vm-type vz --mount-type virtiofs --mount-inotify --vz-rosetta --mount $HOME:w
```

Stop the VM (e.g. to re-spawn with different `--cpus`, `--memory`, or a larger
`--disk`; note that disk can only grow, and `arch` / `vm-type` cannot change at
all — those require `colima delete` first):

```zsh
colima stop
```
