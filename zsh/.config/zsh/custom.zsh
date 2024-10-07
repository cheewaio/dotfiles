# starship
[[ -n "$(command -v starship 2>/dev/null)" ]] || brew install starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# tmux
[[ -n "$(command -v tmux 2>/dev/null)" ]] || brew install tmux
if [[ -z "$TMUX" ]]; then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# fzf
[[ -n "$(command -v fzf 2>/dev/null)" ]] || brew install fzf
source <(fzf --zsh)

# zoxide
[[ -n "$(command -v zoxide 2>/dev/null)" ]] || brew install zoxide
eval "$(zoxide init zsh)"

# pfetch
[[ -n "$(command -v pfetch 2>/dev/null)" ]] || brew install pfetch
pfetch 
