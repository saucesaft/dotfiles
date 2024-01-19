alias ssh="TERM=xterm-256color ssh"

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors '=*=1;34'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/saucesaft/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep nomatch notify
bindkey -v

GEOMETRY_STATUS_SYMBOL="☺"
GEOMETRY_STATUS_SYMBOL_ERROR="☹"

source documents/pkgs/geometry/geometry.zsh
