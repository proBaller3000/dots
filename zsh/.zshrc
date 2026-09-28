export PATH="$HOME/.local/bin:$PATH"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--color=16,bg+:16"

# Starship
# ------------------------------------------------------------------------------
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Zoxide
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Direnv
if type direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# syntax highlighting (MUST be last)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# eza (better `ls`)
# ------------------------------------------------------------------------------
if type eza &>/dev/null; then
  alias l="eza --icons=always"
  alias la="eza -a --icons=always"
  alias lh="eza -ad --icons=always .*"
  alias ll="eza -lg --icons=always"
  alias lla="eza -lag --icons=always"
  alias llh="eza -lagd --icons=always .*"
  alias ls="eza --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lt4="eza -lTg --level=4 --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
  alias lta4="eza -lTag --level=4 --icons=always"
  alias lta="eza -lTag --icons=always"
fi

# Git
# ------------------------------------------------------------------------------
## Aliases
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
alias gds="git diff --staged"
alias gp="git pull"
alias gP="git push"
alias gfa="git fetch --all"

# LazyGit
# ------------------------------------------------------------------------------
alias lg="lazygit"

alias n="nvim"

## Use emacs keymap
bindkey -e
EDITOR=nvim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
