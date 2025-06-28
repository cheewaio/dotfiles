# load all zsh configuration files
local script_dir="$(cd "$(dirname "$0")" && pwd)"
for file in $script_dir/.config/zsh/*.zsh; do
  source "$file"
done

