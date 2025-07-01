## zsh Options
setopt HIST_IGNORE_ALL_DUPS

# zsh-syntax-highlighting
[[ -e "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] || brew install zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
[[ -e "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] || brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship
[[ -n "$(command -v starship 2>/dev/null)" ]] || brew install starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# tmux
[[ -n "$(command -v tmux 2>/dev/null)" ]] || brew install tmux
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "intellij" ]]; then
    tmux attach -t tmux || tmux new -s tmux
fi

# fd
[[ -n "$(command -v fd 2>/dev/null)" ]] || brew install fd

# nvim
[[ -n "$(command -v nvim 2>/dev/null)" ]] || brew install neovim
export EDITOR="nvim"
export VISUAL="nvim"

# git
[[ -n "$(command -v git 2>/dev/null)" ]] || brew install git
export GIT_EDITOR="nvim"

# fzf
[[ -n "$(command -v fzf 2>/dev/null)" ]] || brew install fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--info=inline --reverse --height 40% --color=bg:#262427"

# bat
[[ -n "$(command -v bat 2>/dev/null)" ]] || brew install bat

# yazi
[[ -n "$(command -v yazi 2>/dev/null)" ]] || brew install yazi

# zoxide
[[ -n "$(command -v zoxide 2>/dev/null)" ]] || brew install zoxide
eval "$(zoxide init zsh)"

# pfetch
[[ -n "$(command -v pfetch 2>/dev/null)" ]] || brew install pfetch
pfetch 
