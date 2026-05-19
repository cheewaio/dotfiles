# Dotfiles

macOS dotfiles managed via [GNU Stow](https://www.gnu.org/software/stow/).

## Install / Apply

```sh
# 1. Install dependencies
sh setup/install.sh

# 2. Symlink configs via stow
cd ~/dotfiles
stow -t $HOME zsh nvim tmux starship ghostty
```

`stow` is aliased to `stow -t $HOME` in `zsh/.config/zsh/aliases.zsh:16`.

## Inventory

| Package | Dir | Stow target |
|---------|------|-------------|
| setup | `setup/` | — (bootstrap scripts, not stowed) |
| zsh | `zsh/.config/zsh/` + `zsh/.zshrc` | `~/.config/zsh/`, `~/.zshrc` |
| nvim | `nvim/.config/nvim/` | `~/.config/nvim/` |
| tmux | `tmux/.config/tmux/` | `~/.config/tmux/` |
| starship | `starship/.config/starship/` | `~/.config/starship/` |
| ghostty | `ghostty/.config/ghostty/` | `~/.config/ghostty/` |

## Shell (zsh)

- `~/.zshrc` sources everything in `~/.config/zsh/*.zsh`, then `~/.config/zsh/functions/*.sh`, then `~/.zshrc.local` (optional override).
- `activation.zsh:2` — `setopt HIST_IGNORE_ALL_DUPS`
- Tools installed via `setup/install.sh` (brew + uv); `activation.zsh` configures tools only when found.
- Shell prompt is Starship with Gruvbox Dark palette (`starship.toml`).
- `FZF_DEFAULT_COMMAND` uses `fd` (`activation.zsh`).
- Tmux auto-attaches on terminal open (skipped for vscode/intellij) (`activation.zsh`).

### Key aliases (aliases.zsh)

| Alias | Expands to |
|-------|-----------|
| `cd` | `z` (zoxide) |
| `cdi` | `zi` (zoxide interactive) |
| `ls` | `ls -F` |
| `vi` | `nvim` |
| `cursor` | `open -a Cursor` |
| `k` | `kubectl` |
| `kctx`, `kns`, `kdel`, `kdesc`, `kedit`, `kexec`, `kget`, `klogs`, `kimage` | fzf-powered kubectl wrappers |

### Kubectl helpers (functions/fzf-k8s.sh)

- `kget` — interactive pod list with preview logs, exec, describe, edit, delete, YAML viewing, namespace switching (all via fzf keybinds).
- `kctx` — interactive context switch via fzf.
- `kns` — interactive namespace switch via fzf.
- `kexec` — select pod then container, exec bash/sh.
- `klogs` — select pod then container, logs via bat.

### Docker helper (functions/fzf-docker.sh)

- `dps` — `docker ps` via fzf with exec, inspect, kill, logs, remove, restart keybinds.

### Git fzf (functions/fzf-git.sh)

- Junegunn's `fzf-git.sh` — bindings accessible via `^g` prefix + first letter of category (e.g. `^gf` for files, `^gb` for branches).

## Neovim (AstroNvim v6+)

- Base: AstroNvim v6 template with lazy.nvim bootstrapped via `lazy_setup.lua`.
- Entrypoint: `init.lua` → `lazy_setup.lua` → `community.lua` → `plugins/*.lua` → `polish.lua`.
- Language packs: lua, json, yaml (via `astrocommunity` in `community.lua`).
- Colorscheme: catppuccin (via `astrocommunity.colorscheme.catppuccin`).
- User plugins live in `lua/plugins/`. **Files with `if true then return {} end` as first line are disabled by default** — enable by removing that guard.
- Format on save: enabled globally via AstroLSP (`astrolsp.lua:23`), can be scoped by filetype.
- Reset: `nvim/reset.sh` clears `~/.local/share/nvim`, `~/.local/state/nvim`, `~/.cache/nvim`.
- Upgrade: `nvim/upgrade.sh` backs up config, resets data, clones fresh AstroNvim template, restores `lua/community.lua` and `lua/plugins/*.lua`.

## Tmux

- Prefix: `C-s` (not default `C-b`) (`tmux.conf:2`).
- Config reload: `prefix + r` (`tmux.conf:5`).
- Plugins managed via TPM (`tmux.conf:67`), list in `tmux.conf:20-30`.
- Catppuccin Macchiato theme, status bar at top (`tmux.conf:44-64`).
- Session switcher via `prefix + o` (`@sessionx-bind`, `tmux.conf:33`).
- Pane navigation: vi-style `hjkl` (`tmux.conf:14-17`).
- A `tmux.reset.conf` provides a fallback keybinding reference.
- `.gitignore` excludes `plugins/*` (TPM-installed plugins).

## Starship

- Gruvbox Dark palette, custom segments: os → username → directory → git → language runtimes → docker/conda → time.
- Symbol substitutions for common directory names (`starship.toml:84-87`).

## Ghostty

- Minimal: single `theme = 0x96f` line.

## OpenCode

- `.claude/settings.local.json` allows `Bash(git rm *)`.
