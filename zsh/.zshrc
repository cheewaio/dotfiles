export XDG_CONFIG_HOME="$HOME/.config"

# local customizable dir
local_dir="$HOME/.local/config/zsh"

# aliases
if [[ -f "$XDG_CONFIG_HOME/zsh/aliases.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
fi

# activation script
if [[ -f "$XDG_CONFIG_HOME/zsh/activation.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/activation.zsh"
fi

# functions files
for file in "$XDG_CONFIG_HOME"/zsh/functions/*.sh(N); do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

# local functions files
if [[ -d "$local_dir/functions" ]]; then
  for file in "$local_dir"/functions/*.sh(N); do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi

# local .zsh files
if [[ -d "$local_dir" ]]; then
  for file in "$local_dir"/*.zsh(N); do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi

# final local .zshrc override
local_final="$HOME/.local/config/zsh/.zshrc"
if [[ -f "$local_final" ]]; then
  source "$local_final"
fi


