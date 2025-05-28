# [[ Neovim ]]
alias nvim="$HOME/.local/share/nvim-linux-x86_64/bin/nvim"

# zshrc
alias ezrc="nvim $HOME/.zshrc"
alias rzrc="source $HOME/.zshrc"

# [[ Homebrew ]]
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# [[ Starship ]]
eval "$(starship init zsh)"

# [[ Bat(better cat) ]]
# combine bat with git diff to view lines around code changes with proper syntax highlighting
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
export BAT_THEME=gruvbox-dark
alias cat="bat"

# [[ Eza(better ls) ]]
alias ls="eza --reverse --sort=modified --color=always --long --git --icons=always --no-filesize --no-user --no-permissions"
alias ll="eza --reverse --sort=modified --color=always --long --all --git --icons=always --no-filesize --no-user"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# [[ Fzf ]]
source <(fzf --zsh)

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tre --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# [[ Zoxide(better cd) ]]
eval "$(zoxide init zsh)"
export PATH="$HOME/.local/bin:$PATH"
alias cd="z"

# [[ Thefuck ]]
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# [[ Pyenv ]]
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"


# [[ Tmux ]]
ts() {
  tmux attach -t $1
}
