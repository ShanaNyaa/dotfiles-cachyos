# Dotfiles

Personal macOS configuration for Zsh, tmux, and Neovim. The repository is organized as [GNU Stow](https://www.gnu.org/software/stow/) packages, so each top-level directory mirrors its destination under `$HOME`.

## Included packages

| Package | Destination | Highlights |
| --- | --- | --- |
| `zsh` | `~/.zshrc` | Homebrew completions, NVM, `fzf`, `zoxide`, `eza`, Yazi, Lazygit, Oh My Posh, and Zsh completion/syntax plugins |
| `tmux` | `~/.config/tmux` | `C-Space` prefix, vim-style panes, macOS clipboard support, Catppuccin Mocha theme, and session persistence |
| `nvim` | `~/.config/nvim` | LazyVim configuration with Copilot, Telescope, JSON, and TOML extras |
| `btop` | `~/.config/btop` | Catppuccin Mocha theme (Frappe, Macchiato, and Latte variants included) |
| `oh-my-posh` | `~/.config/oh-my-posh` | `shana.omp.json` prompt theme used by `zsh/.zshrc`, plus bundled `atomic`, `catppuccin`, and `M365Princess` themes |

## Prerequisites

Install Homebrew first, then install the command-line tools used by these configurations:

```zsh
brew install stow git neovim tmux nvm eza fzf zoxide yazi lazygit oh-my-posh \
	zsh-autosuggestions zsh-syntax-highlighting btop
```

Use a Nerd Font in your terminal emulator so icons in `eza`, tmux, and Neovim render correctly.

The Zsh configuration expects an Oh My Posh theme at `~/.config/oh-my-posh/shana.omp.json`; the `oh-my-posh` package links it (and a few alternate themes) into place. Change the path in `zsh/.zshrc` to use a different bundled theme, or remove the Oh My Posh initialization if it is not needed.

## Installation

Clone this repository, change into it, and preview the links before creating them:

```zsh
git clone <your-repository-url> ~/dotfiles
cd ~/dotfiles
stow -n -v -t "$HOME" zsh tmux nvim btop oh-my-posh
```

If the dry run looks correct, create the symlinks:

```zsh
stow -v -t "$HOME" zsh tmux nvim btop oh-my-posh
```

Stow reports a conflict when a destination already exists. Review and back up any existing configuration before resolving the conflict; do not overwrite it blindly.

## First run

- Start a new Zsh session after linking `~/.zshrc`.
- Start tmux with `tmux`; its bundled TPM and theme files are linked with the tmux package.
- Open Neovim with `nvim`; `lazy.nvim` bootstraps itself and installs the configured plugins on first launch.

## Customization notes

- The LM Studio CLI path in `zsh/.zshrc` is specific to its original machine. Update or remove it on another Mac.
- `tmux` uses `pbcopy` for copy-mode selection on macOS and `xclip` on other systems.
- `btop` defaults to the Catppuccin Mocha theme; switch themes by pointing `color_theme` in `btop/.config/btop/btop.conf` at one of the other bundled `.theme` files.
- To remove links created by Stow, run `stow -D -t "$HOME" zsh tmux nvim btop oh-my-posh` from this repository.
