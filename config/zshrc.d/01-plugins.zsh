# ~/.zshrc.d/01-plugins.zsh

# Syntax Highlighting
[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Autosuggestions
[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Powerlevel10k theme (si no lo carga el prompt)
[ -f "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ] && \
  source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
