# ~/.zshrc.d/00-core.zsh

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Prompt personalizado (Powerlevel10k)
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Configuración de historial
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Opciones útiles
setopt autocd           # Entrar a carpetas sin 'cd'
setopt correct          # Corregir errores de comando (opcional)
setopt nocaseglob       # Expansión insensible a mayúsculas
setopt append_history   # Añadir al historial en vez de sobrescribir
