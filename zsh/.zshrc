# zsh Options
setopt HIST_IGNORE_ALL_DUPS

# Aliases
[[ -e "$HOME/.config/zsh/aliases.zsh" ]] && source "$HOME/.config/zsh/aliases.zsh"

# Custom zsh
[[ -e "$HOME/.config/zsh/custom.zsh" ]] && source "$HOME/.config/zsh/custom.zsh"

# Development
[[ -e "$HOME/.config/zsh/dev.zsh" ]] && source "$HOME/.config/zsh/dev.zsh"

# Work
[[ -e "$HOME/.config/zsh/work.zsh" ]] && source "$HOME/.config/zsh/work.zsh"
