# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load homebrew formulae completions into FPATH
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load zsh plugins
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
antidote load

# Other scripts which won't be included in backup
if [ -f $HOME/.zsh_bootstrap ]; then
  source $HOME/.zsh_bootstrap
fi

# Load p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# vim: ts=2 sts=2 sw=2 et
