# Set XDG variables for config and data dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Docker CLI doesn't respect XDG, needs explicit override
# https://github.com/docker/cli/issues/6729
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Uv
export PATH="$HOME/.local/share/../bin:$PATH"

# Npm
# ...
