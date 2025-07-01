export XDG_CONFIG_HOME="$HOME/.config"

# Load all zsh configuration files
for file in "$XDG_CONFIG_HOME/zsh"/*.zsh; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

# Load all zsh functions files
for file in "$XDG_CONFIG_HOME/zsh/functions"/*.sh; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done