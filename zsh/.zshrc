# ~/.zshrc — loaded only for INTERACTIVE shells (prompt, aliases, completions, plugins)

# --- 1. Ensure needed dirs exist (safe to run every time) ---
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# --- 2. Completion settings & initialization ---
#NOTE: Disable case sensitivity for tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit
compdef _podman docker  # `docker` is podman-docker's shim; podman only ships a `_podman` completion

# --- 3. NVM ---
source /usr/share/nvm/init-nvm.sh

# --- 4. History options ---
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# --- 5. Aliases ---
alias ls="eza --icons=always --color=always"
alias ll="eza -lh --icons=always --color=always"
alias la="eza -la --icons=always --color=always"
alias ta="tmux new -A -s"
alias tl="tmux ls"
alias cls="clear"

# --- 6. Keybindings ---
# Ctrl (word-wise editing)
bindkey '^[[1;5C' forward-word        # Ctrl+Right
bindkey '^[[1;5D' backward-word       # Ctrl+Left
bindkey '^H'      backward-kill-word  # Ctrl+Backspace

# Alt (line-wise editing, like Cmd on macOS)
bindkey '^[[1;3C' end-of-line         # Alt+Right
bindkey '^[[1;3D' beginning-of-line   # Alt+Left
bindkey '^[^?'    backward-kill-line  # Alt+Backspace (kill line before cursor)

# Ctrl+A/E (line-wise editing, Home/End style)
bindkey '^A' beginning-of-line        # Ctrl+A
bindkey '^E' end-of-line              # Ctrl+E

# --- 7. Shell behavior ---
#NOTE: Suggest corrections for mystyped commands
setopt CORRECT
setopt CORRECT_ALL

# --- 8. Themes & plugins (must load after compinit) ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if type oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init zsh --config "$XDG_CONFIG_HOME/oh-my-posh/shana.omp.json")"
fi

# --- 9. fzf ---
if [[ -f "$XDG_CONFIG_HOME/fzf/.fzfrc" ]]; then
  export FZF_DEFAULT_OPTS="$(sed -e '/^[[:space:]]*#/d' -e 's/[[:space:]]#.*$//' -e '/^[[:space:]]*$/d' "$XDG_CONFIG_HOME/fzf/.fzfrc")"
fi

# fzf preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
type fzf &>/dev/null && source <(fzf --zsh)

# --- 10. Zoxide ---
type zoxide &>/dev/null && eval "$(zoxide init zsh)"

# --- 11. Yazi (cd to last dir on exit) ---
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# --- 12. Lazygit (cd to last dir on exit) ---
function lg() {
  export LAZYGIT_NEW_DIR_FILE="$XDG_STATE_HOME/lazygit/newdir"
  mkdir -p "$(dirname "$LAZYGIT_NEW_DIR_FILE")"
  lazygit "$@"
  if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
    cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
    rm -f "$LAZYGIT_NEW_DIR_FILE"
  fi
}

# --- 13. Fastfetch on boot (optional) ---
# if [[ -o interactive ]]; then
#   fastfetch
# fi

# --- zsh-syntax-highlighting: MUST be the very last line ---
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
