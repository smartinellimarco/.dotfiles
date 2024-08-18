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
- [Tips & Troubleshooting](#tips-troubleshooting)
<!--toc:end-->

## Getting started

### Requirements

Install [homebrew](https://brew.sh/) and follow post-installation steps.

```zsh
# Taps
brew tap hashicorp/tap
brew tap homebrew/cask-fonts

# Dependencies
dependencies=(
  git           # lazy, mason, treesitter
  curl          # mason, treesitter
  jq            
  unzip         # mason
  gnu-tar       # mason, treesitter
  gzip          # mason
  luarocks      # lazy
  gcc           # treesitter, telescope
  ripgrep       # telescope
  fd            # telescope
  make          # telescope
  llvm          # telescope, treesitter (clang)
  wget          # mason
  bash          # mason
  sh            # mason

  # see LSP and formatters requirements 
  nvm
  pyenv     
  poetry        
  python        
  go            
  delve         
  hashicorp/tap/terraform  # Hashicorp

  gh
  zsh           
  antidote     
  yadm        
  neovim   
  gpg     

  openssl       # pyenv
  readline      # pyenv
  sqlite3       # pyenv
  xz            # pyenv
  zlib          # pyenv
  tcl-tk        # pyenv
)

# Casks
cask_dependencies=(
  font-symbols-only-nerd-font  # Font
  font-jetbrains-mono          # Font
  kitty                        # Terminal
)

# Install regular dependencies
for package in "${dependencies[@]}"; do
  if ! brew list $package &>/dev/null; then
    brew install $package
  fi
done

# Install cask dependencies
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

## Tips & Troubleshooting

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

See ':h clipboard'.

</details>
