# Set XDG variables for config and data dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Docker CLI doesn't respect XDG, needs explicit override
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Prevent colima from overwriting profile settings
export COLIMA_SAVE_CONFIG=0
