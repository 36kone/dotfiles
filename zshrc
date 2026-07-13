eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/kone/.opencode/bin:$PATH"
export PATH="$(brew --prefix go)/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"

f() {
  local file
  local finder
  local mime

  if command -v fd >/dev/null 2>&1; then
    finder="fd"
  elif command -v fdfind >/dev/null 2>&1; then
    finder="fdfind"
  else
    echo "fd/fdfind não encontrado"
    return 1
  fi

  file="$("$finder" --type f --hidden --follow --exclude .git | \
  fzf \
    --preview 'bat --style=numbers --color=always --line-range=:500 {}' \
    --preview-window=right:40%)"

  if [ -z "$file" ]; then
    return 0
  fi

  mime="$(file --mime-type -b "$file")"

  case "$mime" in
    text/*|application/json|application/xml|application/x-yaml|application/yaml|application/javascript|application/x-shellscript)
      nvim "$file"
      ;;
    *)
      xdg-open "$file" >/dev/null 2>&1 &
      ;;
  esac
}

alias ls="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --sort=extension"
alias tree="eza --tree"
alias lg="lazygit"

export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
