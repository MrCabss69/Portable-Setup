# ~/.zshrc

# Carga de configuraciones modulares
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d/"*.zsh; do
    [ -f "$file" ] && source "$file"
  done
fi

# Load shared configs
[ -f "$HOME/.commonrc.d/load_common.sh" ] && source "$HOME/.commonrc.d/load_common.sh"
