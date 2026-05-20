# Dotfiles

This repository contains configuration files (dotfiles) for setting up your development environment.

## Usage

1. **Clone the repository:**
   ```sh
   git clone https://github.com/cheewaio/dotfiles.git ~/dotfiles
   ```

2. **Install GNU Stow:**  
   If you don't have Stow installed, install it using your package manager. For example:
   ```sh
   # macOS (Homebrew)
   brew install stow
   ```

3. **Stow your dotfiles:**  
   From inside the dotfiles directory, use Stow to symlink the configuration files you want. For example:
   ```sh
   cd ~/dotfiles
   stow ghostty
   stow nvim
   stow starship
   stow zsh
   ```
   This will create symlinks in your home directory for the selected configurations.

4. **Reload your shell:**  
   After stowing, reload your shell or restart your terminal to apply changes.

## Zsh Customization

`.zshrc` sources in this order (later overrides earlier):
1. `~/.config/zsh/*.zsh` — stowed config (core settings)
2. `~/.config/zsh/functions/*.sh` — stowed functions
3. `~/.config/zsh-local/*.zsh` — **local overrides** (env, aliases)
4. `~/.config/zsh-local/functions/*.sh` — **local functions** (custom fzf, etc.)
5. `~/.zshrc.local` — final escape hatch

Items 3–5 live **outside the dotfiles repo** — use them for machine-specific customizations at work.

To get started:

```sh
mkdir -p ~/.config/zsh-local/functions
```

| File | What to put there |
|------|------------------|
| `~/.config/zsh-local/env.zsh` | Custom env vars (`$PROJECT_HOME`, proxy, etc.) |
| `~/.config/zsh-local/aliases.zsh` | Custom aliases, tool overrides |
| `~/.config/zsh-local/functions/*.sh` | Custom fzf wrappers, helper functions |
| `~/.zshrc.local` | Quick one-off overrides (single file, no dir setup) |

## Disclaimer

Use these files at your own risk. Always back up your existing configuration files before replacing them.
