#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

# Allow users to optionally configure their tmux plugin path and set the
# value if one doesn't exist. This runs each time a script is switched
# so it's important to check for previously set values.

if [ -z "$BASE16_SHELL_TMUXCONF_PATH" ]; then
  BASE16_SHELL_TMUXCONF_PATH="$BASE16_CONFIG_PATH/tmux.base16.conf"
fi

if [ -z "$BASE16_TMUX_PLUGIN_PATH" ]; then
  BASE16_TMUX_PLUGIN_PATH="$HOME/.tmux/plugins/base16-tmux"
fi

# If base16-tmux path directory doesn't exist, stop hook
if [ ! -d $BASE16_TMUX_PLUGIN_PATH ]; then
  return 2
fi

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

# If base16-tmux is used, provide a file for base16-tmux to source
if [ -d "$BASE16_TMUX_PLUGIN_PATH" ]; then 
  echo -e "set -g \0100colors-base16 '$theme_name'" >| \
    "$BASE16_SHELL_TMUXCONF_PATH"

  # Source tmux config
  tmux source-file $(tmux display-message -p "#{config_files}")
fi
