export XDG_CONFIG_HOME="$HOME/.config"

# Load aliases
if [[ -f "$XDG_CONFIG_HOME/zsh/aliases.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
fi

# Load all zsh functions files
for file in "$XDG_CONFIG_HOME"/zsh/functions/*.sh(N); do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

# machine-local overrides (outside stow, not in dotfiles repo)
local_dir="$HOME/.local/config/zsh"
if [[ -d "$local_dir" ]]; then
  for file in "$local_dir"/*.zsh(N); do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi
if [[ -d "$local_dir/functions" ]]; then
  for file in "$local_dir"/functions/*.sh(N); do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi

# final override escape hatch
local_final="$HOME/.local/config/zsh/.zshrc"
if [[ -f "$local_final" ]]; then
  source "$local_final"
fi

# Load the activation script
if [[ -f "$XDG_CONFIG_HOME/zsh/activation.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/activation.zsh"
fi
