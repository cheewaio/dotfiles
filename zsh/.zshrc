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

# machine-local overrides (outside stow, not in dotfiles repo)
local_dir="$XDG_CONFIG_HOME/.config/zsh-local"
if [[ -d "$local_dir" ]]; then
  for file in "$local_dir"/*.zsh; do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
  for file in "$local_dir/functions"/*.sh; do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi

# final override escape hatch
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
