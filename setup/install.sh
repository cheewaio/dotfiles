#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew packages..."
xargs brew install <"$DIR/brew-packages.txt"

echo "==> Installing uv packages..."
while IFS= read -r pkg; do
  [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
  uv $pkg
done <"$DIR/uv-packages.txt"

echo "==> Preparing ~/.local/config/zsh for machine-local overrides..."
mkdir -p "$HOME/.local/config/zsh/functions"
for f in "$DIR/zsh/.zshrc" "$DIR/zsh/env.zsh" "$DIR/zsh/aliases.zsh"; do
  dest="$HOME/.local/config/zsh/$(basename "$f")"
  [[ ! -f "$dest" ]] && cp "$f" "$dest"
done

echo "==> Stowing dotfiles to $HOME..."
if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
  echo "    Backing up existing ~/.zshrc to ~/.zshrc.bak"
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
stow -d "$DIR/.." -t "$HOME" zsh nvim tmux starship ghostty

echo "==> Done! Reload your shell or run: source ~/.zshrc"
