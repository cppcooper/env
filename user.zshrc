#!/usr/bin/zsh

# Enable completion system
autoload -Uz compinit
compinit

# Enable syntax highlighting (requires plugin)
# brew install zsh-syntax-highlighting   OR   pacman -S zsh-syntax-highlighting
# Then:
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable autosuggestions (requires plugin)
# pacman -S zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt append_history
setopt hist_ignore_dups
setopt share_history   # share across terminals

# Prompt (zsh calls it PROMPT instead of PS1)
autoload -Uz colors && colors
PROMPT='%F{cyan}%n%f@%F{yellow}%m%f:%F{green}%~%f %# '

# Show command timestamp after execution
precmd() {
  printf '%s\n' "[`date '+%Y-%m-%d %H:%M:%S'`] Command finished"
}
