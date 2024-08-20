# TODO: ctrl + l push to scrollback without delete

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Homebrew formulae completions into FPATH
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load antidote
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"

# Set cache for the completion plugin
zstyle ':plugin:ez-compinit' 'use-cache' 'yes'

# zsh-autosuggestions configuration
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

# Load plugins
antidote load

# Source additional scripts (won't be included in backup)
[ -f "$HOME/.zsh_bootstrap" ] && source "$HOME/.zsh_bootstrap"

# Load Powerlevel10k configuration
[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"

# vim: ts=2 sts=2 sw=2 et
