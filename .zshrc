# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load homebrew formulae completions into FPATH
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load zsh plugins
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

# Config for zsh-autosuggestions
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-word)

# Word movement
bindkey "^f" forward-word
bindkey "^b" backward-word

# Remove '/' from wordchars to be able to navigate directories
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History configuration
# TODO: review
# see: https://zsh.sourceforge.io/Doc/Release/Options.html#History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

# This is like enabling inc_append_history too
setopt share_history
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_save_no_dups
setopt hist_reduce_blanks

antidote load

# Other scripts which won't be included in backup
if [ -f $HOME/.zsh_bootstrap ]; then
  source $HOME/.zsh_bootstrap
fi

# Load p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# vim: ts=2 sts=2 sw=2 et
