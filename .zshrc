# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set editor
export EDITOR=hx

# Load Homebrew formulae completions into FPATH
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

# TODO: https://github.com/ohmyzsh/ohmyzsh/issues/12762
# Case insensitive completion and subword completion
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' \
  'r:|=*' \
  'l:|=* r:|=*'

# Remove '/' from wordchars to be able to navigate directories
WORDCHARS=${WORDCHARS//\//}

# History configuration
HISTFILE="$HOME/.zsh_history"  # History file path
HISTSIZE=1000000               # Max commands in memory
SAVEHIST=1000000               # Max commands in history file

setopt share_history           # Share history across sessions
setopt hist_ignore_all_dups    # Remove all duplicates
setopt hist_find_no_dups       # Don't show duplicates in search
setopt hist_expire_dups_first  # Expire old duplicates first
setopt hist_ignore_space       # Ignore commands starting with a space
setopt hist_ignore_dups        # Ignore consecutive duplicates
setopt hist_save_no_dups       # Don't save duplicate commands
setopt hist_reduce_blanks      # Trim extra spaces before saving

# Source antidote
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

# Initialize plugins
antidote load

# Initialize mise
eval "$(mise activate zsh)"

# Load Powerlevel10k configuration
[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh" || true

# Source custom keymaps
[ -f "$HOME/.zsh_keymaps" ] && source "$HOME/.zsh_keymaps" || true

# Source additional scripts (won't be included in backup)
[ -f "$HOME/.zsh_bootstrap" ] && source "$HOME/.zsh_bootstrap" || true
