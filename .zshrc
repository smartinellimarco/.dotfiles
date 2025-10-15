# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set editor
export EDITOR=hx

# Load Homebrew formulae completions into FPATH
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

# TODO: https://github.com/ohmyzsh/ohmyzsh/issues/12762
# Case insensitive completion and subword completion
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' \
  'r:|=*' \
  'l:|=* r:|=*'

# Allow interactive comments
setopt interactive_comments

# Remove '/' from wordchars to be able to navigate directories
WORDCHARS=${WORDCHARS//\//}

# History configuration
HISTFILE="$HOME/.zsh_history"  # History file path
HISTSIZE=1000000  # Max commands in memory
SAVEHIST=1000000  # Max commands in history file

setopt share_history  # Share history across sessions
setopt hist_ignore_all_dups  # Remove all duplicates
setopt hist_find_no_dups  # Don't show duplicates in search
setopt hist_expire_dups_first  # Expire old duplicates first
setopt hist_ignore_space  # Ignore commands starting with a space
setopt hist_ignore_dups  # Ignore consecutive duplicates
setopt hist_save_no_dups  # Don't save duplicate commands
setopt hist_reduce_blanks  # Trim extra spaces before saving

# Source antidote
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

# Initialize plugins
antidote load

# Load Powerlevel10k configuration
[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh" || true

# Source additional scripts (won't be included in backup)
[ -f "$HOME/.zsh_bootstrap" ] && source "$HOME/.zsh_bootstrap" || true

# Unbind all default keymaps
bindkey -rp ''

# Set custom keymaps
bindkey "^[[200~" bracketed-paste  # Paste
bindkey -R " "-"~" self-insert  # Enable self-insert for a-z, A-Z, 0-9, and symbols
bindkey "^F" forward-word  # Move forward by word
bindkey "^B" backward-word  # Move backward by word
bindkey "^A" beginning-of-line  # Move to beginning of line
bindkey "^E" end-of-line  # Move to end of linebindkey "^[[C" forward-char
bindkey "^[[C" forward-char  # Move forward by char
bindkey "^[[D" backward-char  # Move backward by char
bindkey "^W" backward-kill-word  # Delete previous word
bindkey "^?" backward-delete-char  # Delete previous char
bindkey "^M" accept-line  # Run command
bindkey ";5;13~" accept-line  # Run command event with CTRL pressed for efficiency
bindkey "^C" send-break  # Stop signal
bindkey "^L" clear-screen  # Clear screen
bindkey "^R" history-incremental-search-backward  # Reverse search in history
bindkey "^P" up-line-or-history  # Navigate up in history
bindkey "^N" down-line-or-history  # Navigate down in history
bindkey "^I" expand-or-complete  # Tab completion
