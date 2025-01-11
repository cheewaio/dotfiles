# starship
[[ -n "$(command -v starship 2>/dev/null)" ]] || brew install starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# tmux
[[ -n "$(command -v tmux 2>/dev/null)" ]] || brew install tmux
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "intellij" ]]; then
    tmux attach -t tmux || tmux new -s tmux
fi

# zsh-syntax-highlighting
[[ -e "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] || brew install zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
[[ -e "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] || brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
[[ -n "$(command -v fzf 2>/dev/null)" ]] || brew install fzf
source <(fzf --zsh)

# zoxide
[[ -n "$(command -v zoxide 2>/dev/null)" ]] || brew install zoxide
eval "$(zoxide init zsh)"

# pfetch
[[ -n "$(command -v pfetch 2>/dev/null)" ]] || brew install pfetch
pfetch 
