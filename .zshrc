# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Homebrew formulae completions into FPATH
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

# Set cache for the completion plugin
# Run 'run-compinit' after installing new completions
zstyle ':plugin:ez-compinit' 'use-cache' 'yes'

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# zsh-autosuggestions configuration
# After modifying these settings, run: '_zsh_autosuggest_bind_widgets'
ZSH_AUTOSUGGEST_MANUAL_REBIND=
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-word)

# Word movement bindings
bindkey "^f" forward-word
bindkey "^b" backward-word

# Remove '/' from wordchars to be able to navigate directories
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=100000

setopt share_history
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks

# Plugin files (.txt and .zsh)
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Lazy-load antidote
fpath=($HOMEBREW_PREFIX/opt/antidote/share/antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source static plugins.
source ${zsh_plugins}.zsh

# Load powerlevel10k prompt
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# Load Powerlevel10k configuration
[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"

# Source additional scripts (won't be included in backup)
[ -f "$HOME/.zsh_bootstrap" ] && source "$HOME/.zsh_bootstrap"

# vim: ts=2 sts=2 sw=2 et
