## zsh Options
setopt HIST_IGNORE_ALL_DUPS

# Homebrew and app upgrades can leave stale completion symlinks behind.
for completion_dir in $fpath; do
  [[ -d "$completion_dir" ]] || continue
  for completion_file in "$completion_dir"/*(N@); do
    [[ -e "$completion_file" ]] || rm -f "$completion_file"
  done
done

# completion system
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least add-zsh-hook

# zsh-syntax-highlighting
if [[ -n "$(command -v brew 2>/dev/null)" ]]; then
  _zp="$(brew --prefix)/share/zsh-syntax-highlighting"
  [[ -e "$_zp/zsh-syntax-highlighting.zsh" ]] && source "$_zp/zsh-syntax-highlighting.zsh"
fi

# zsh-autosuggestions
if [[ -n "$(command -v brew 2>/dev/null)" ]]; then
  _zp="$(brew --prefix)/share/zsh-autosuggestions"
  [[ -e "$_zp/zsh-autosuggestions.zsh" ]] && source "$_zp/zsh-autosuggestions.zsh"
fi

# starship
if [[ -n "$(command -v starship 2>/dev/null)" ]]; then
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"
fi

# tmux
if [[ -n "$(command -v tmux 2>/dev/null)" ]]; then
  if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != vscode ]] && [[ "$TERM_PROGRAM" != intellij ]]; then
    tmux attach -t tmux || tmux new -s tmux
  fi
fi

# nvim
if [[ -n "$(command -v nvim 2>/dev/null)" ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# git
if [[ -n "$(command -v git 2>/dev/null)" ]]; then
  export GIT_EDITOR="nvim"
fi

# fzf
if [[ -n "$(command -v fzf 2>/dev/null)" ]]; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_DEFAULT_OPTS="--info=inline --reverse --height 40% --color=bg:#262427"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# zoxide
if [[ -n "$(command -v zoxide 2>/dev/null)" ]]; then
  eval "$(zoxide init zsh)"
fi

# pfetch
[[ -n "$(command -v pfetch 2>/dev/null)" ]] && pfetch
