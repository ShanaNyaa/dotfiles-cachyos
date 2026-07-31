# Dotfiles

Personal macOS configuration for Zsh, tmux, Neovim, Ghostty, and assorted CLI tools. The repository is organized as [GNU Stow](https://www.gnu.org/software/stow/) packages, so each top-level directory mirrors its destination under `$HOME`. The `ghostty` and `delta` packages each include a Git submodule (cursor shaders and the Catppuccin theme, respectively), so clone with `--recurse-submodules` (or run `git submodule update --init` after cloning).

## Included packages

| Package | Destination | Highlights |
| --- | --- | --- |
| `zsh` | `~/.zshrc`, `~/.zshenv` | XDG env vars, Homebrew/NVM setup, `nvim` as `EDITOR`/`VISUAL`/`MANPAGER`, `fzf` (with `bat`/`eza`-powered Ctrl+T and Alt+C previews), `zoxide`, `eza`, Yazi, Lazygit, Oh My Posh, and Zsh completion/syntax plugins |
| `tmux` | `~/.config/tmux` | `C-Space` prefix, vim-style panes, macOS clipboard support, Catppuccin Mocha theme, and session persistence |
| `nvim` | `~/.config/nvim` | LazyVim configuration with Copilot, Telescope, Ghostty config syntax highlighting, JSON, and TOML extras |
| `btop` | `~/.config/btop` | Catppuccin Mocha theme (Frappe, Macchiato, and Latte variants included) |
| `oh-my-posh` | `~/.config/oh-my-posh` | `shana.omp.json` prompt theme used by `zsh/.zshrc`, plus bundled `atomic`, `catppuccin`, and `M365Princess` themes |
| `yazi` | `~/.config/yazi` | Catppuccin Mocha theme, keymap, and Catppuccin theme variants (Frappe, Latte, Macchiato, Mocha, all accent colors) |
| `bat` | `~/.config/bat` | Catppuccin Mocha syntax theme, used as the preview command for `fzf`'s Ctrl+T binding |
| `fzf` | `~/.config/fzf` | Catppuccin Mocha color options and vim-style preview-scroll bindings, loaded via `FZF_DEFAULT_OPTS` in `zsh/.zshrc` |
| `lazygit` | `~/.config/lazygit` | Lazygit configuration with Catppuccin theme variants (Frappe, Latte, Macchiato, Mocha, all accent colors), invoked via the `lg` shell function in `zsh/.zshrc`; its diff pager is `delta`, themed with the Catppuccin `delta` submodule (`lg` also `cd`s to the last directory browsed on exit) |
| `ghostty` | `~/.config/ghostty` | Catppuccin theme (Latte in light mode, Mocha in dark mode), background blur, and cursor shaders (submodule) |
| `delta` | `~/.config/delta` | Catppuccin theme for `git-delta` (submodule), used only as Lazygit's diff pager via `--config`/`--features` — plain `git diff` is untouched |

## Prerequisites

Install Homebrew first, then install the command-line tools used by these configurations:

```zsh
brew install stow git neovim tmux nvm eza fzf zoxide yazi lazygit oh-my-posh \
	zsh-autosuggestions zsh-syntax-highlighting btop bat git-delta
```

Install [Ghostty](https://ghostty.org) separately (it is a GUI app, not a Homebrew formula).

Use a Nerd Font in your terminal emulator so icons in `eza`, tmux, Neovim, and Ghostty render correctly.

The Zsh configuration expects an Oh My Posh theme at `~/.config/oh-my-posh/shana.omp.json`; the `oh-my-posh` package links it (and a few alternate themes) into place. Change the path in `zsh/.zshrc` to use a different bundled theme, or remove the Oh My Posh initialization if it is not needed.

## Installation

Clone this repository (with submodules), change into it, and preview the links before creating them:

```zsh
git clone --recurse-submodules <your-repository-url> ~/dotfiles
cd ~/dotfiles
stow -n -v -t "$HOME" zsh tmux nvim btop oh-my-posh yazi fzf lazygit ghostty bat delta
```

If the dry run looks correct, create the symlinks:

```zsh
stow -v -t "$HOME" zsh tmux nvim btop oh-my-posh yazi fzf lazygit ghostty bat delta
```

Stow reports a conflict when a destination already exists. Review and back up any existing configuration before resolving the conflict; do not overwrite it blindly.

## First run

- Start a new Zsh session after linking `~/.zshrc` and `~/.zshenv`.
- Start tmux with `tmux`; its bundled TPM and theme files are linked with the tmux package.
- Open Neovim with `nvim`; `lazy.nvim` bootstraps itself and installs the configured plugins on first launch.
- Open Ghostty; it picks up `~/.config/ghostty/config.ghostty` automatically, and reloads with `Cmd+Shift+,`.

## Customization notes

- The LM Studio CLI path in `zsh/.zshenv` is specific to its original machine. Update or remove it on another Mac.
- `tmux` uses `pbcopy` for copy-mode selection on macOS and `xclip` on other systems.
- `btop` defaults to the Catppuccin Mocha theme; switch themes by pointing `color_theme` in `btop/.config/btop/btop.conf` at one of the other bundled `.theme` files.
- `yazi` ships with Catppuccin Mocha colors in `theme.toml`; swap in one of the other flavor/accent combinations under `yazi/.config/yazi/themes/catppuccin/`. `overall.bg` is commented out so Yazi uses the terminal's own background instead of a hardcoded color.
- `bat` defaults to the `Catppuccin Mocha` theme in `bat/.config/bat/config`; run `bat --list-themes` to see other options, and `bat cache --build` after changing themes if you add custom ones.
- `fzf/.config/fzf/.fzfrc` supports `#` comments and blank lines for readability; `zsh/.zshrc` strips them with `sed` before exporting `FZF_DEFAULT_OPTS`, since the file is concatenated as a raw options string rather than sourced as a script.
- `ghostty` switches theme automatically between Catppuccin Latte (light) and Catppuccin Mocha (dark); the active cursor shader is set via the uncommented `custom-shader` line in `ghostty/.config/ghostty/config.ghostty`.
- The Ghostty cursor shaders are pulled in as a Git submodule from [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders); run `git submodule update --remote` to update them.
- The Catppuccin `delta` theme is pulled in as a Git submodule from [catppuccin/delta](https://github.com/catppuccin/delta); run `git submodule update --remote` to update it. Lazygit's `pagers` entry in `lazygit/.config/lazygit/config.yml` points `delta` at this submodule's `catppuccin.gitconfig` via `--config` and activates a flavor via `--features` (e.g. `catppuccin-mocha`), so the theme only applies inside Lazygit's diff view and never touches `~/.gitconfig` or plain `git diff` output.
- To remove links created by Stow, run `stow -D -t "$HOME" zsh tmux nvim btop oh-my-posh yazi fzf lazygit ghostty bat delta` from this repository.
