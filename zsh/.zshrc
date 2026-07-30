# ~/.zshrc — loaded only for INTERACTIVE shells (prompt, aliases, completions, plugins)

# --- 1. Ensure needed dirs exist (safe to run every time) ---
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# --- 2. Completion settings & initialization ---
#NOTE: Disable case sensitivity for tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit

# --- 3. History options ---
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# --- 4. NVM ---
if type brew &>/dev/null; then
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# --- 5. Aliases ---
alias ls="eza --icons=always --color=always"
alias ll="eza -lh --icons=always --color=always"
alias la="eza -la --icons=always --color=always"
alias ta="tmux new -A -s"
alias tl="tmux ls"
alias cls="clear"

# --- 6. Shell behavior ---
#NOTE: Suggest corrections for mystyped commands
setopt CORRECT
setopt CORRECT_ALL

# Bind sequences for ALT+Arrow keys
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# Bind sequences for ALT+Backspace (DEL and BS variants)
bindkey '^[^?' backward-kill-word   # Alt+Backspace (DEL variant)
bindkey '^H'   backward-kill-word   # Alt+Backspace (BS variant, some terminals)

# --- 7. Themes & plugins (must load after compinit) ---
if type brew &>/dev/null; then
  [ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ] && type oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init zsh --config "$XDG_CONFIG_HOME/oh-my-posh/shana.omp.json")"
fi

# --- 8. fzf ---
if [[ -f "$XDG_CONFIG_HOME/fzf/.fzfrc" ]]; then
  export FZF_DEFAULT_OPTS="$(sed -e '/^[[:space:]]*#/d' -e 's/[[:space:]]#.*$//' -e '/^[[:space:]]*$/d' "$XDG_CONFIG_HOME/fzf/.fzfrc")"
fi

# fzf preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
type fzf &>/dev/null && source <(fzf --zsh)

# --- 9. Zoxide ---
type zoxide &>/dev/null && eval "$(zoxide init zsh)"

# --- 10. Yazi (cd to last dir on exit) ---
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# --- 11. Lazygit (cd to last dir on exit) ---
function lg() {
  export LAZYGIT_NEW_DIR_FILE="$XDG_STATE_HOME/lazygit/newdir"
  mkdir -p "$(dirname "$LAZYGIT_NEW_DIR_FILE")"
  lazygit "$@"
  if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
    cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
    rm -f "$LAZYGIT_NEW_DIR_FILE"
  fi
}

# --- 12. Fastfetch on boot (optional) ---
# if [[ -o interactive ]]; then
#   fastfetch
# fi

# --- zsh-syntax-highlighting: MUST be the very last line ---
if type brew &>/dev/null; then
  [ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
