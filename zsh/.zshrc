# Initialize FastFetch on boot
# if [[ -o interactive ]]; then
#    fastfetch
# fi
# End of FastFetch initialization

# --- 1. COMPLETION PATHS & ENVIRONMENT ---
# Add Homebrew's completion path to fpath BEFORE initializing completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/shana/.lmstudio/bin"

# Change default man page viewer to Neovim
# export MANPAGER='nvim +Man!'

# GPG TTY fix for GPG signing in Git
export GPG_TTY=$(tty)

# --- 2. COMPLETION SETTINGS & INITIALIZATION ---
# Disable case sensitivity for tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Initialize completions EXACTLY ONCE here (handles eza, brew, etc.)
autoload -Uz compinit && compinit

# --- 3. ALIASES ---
alias ls="eza --icons=always --color=always" 
alias ll="eza -lh --icons=always --color=always" 
alias la="eza -la --icons=always --color=always" 
alias ta="tmux new -A -s"
alias tl="tmux ls"
alias cls="clear"
alias lg="lazygit"

# Suggest corrections for mistyped commands
setopt CORRECT
setopt CORRECT_ALL

# Bind sequences for ALT+arrow keys to move by word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# --- 4. THEMES & PLUGINS (Must load after compinit) ---
# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Oh My Posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config '~/.config/oh-my-posh/shana.omp.json')"
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_DEFAULT_OPTS=" \
  --color=spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"

# Zoxide
eval "$(zoxide init zsh)"

# Yazi (Change working directory after running a command)
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Lazygit (Chane working directory after running a command)
function lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
          cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
          rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# zsh-syntax-highlighting (CRITICAL: This must always be the very last line)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
