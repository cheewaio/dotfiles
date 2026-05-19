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

echo "==> Done! Run: cd $DIR/.. && stow zsh nvim tmux starship ghostty"
