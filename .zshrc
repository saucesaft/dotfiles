export ZSH="/Users/saucesaft/.oh-my-zsh"
ZSH_THEME="geometry/geometry"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

export DEVKITPRO=/opt/devkitpro
export DEVKITARM="${DEVKITPRO}/devkitARM"
export DEVKITPPC="${DEVKITPRO}/devkitPPC"
export PATH="${DEVKITPRO}/tools/bin:${PATH}"

PATH=$(pyenv root)/shims:$PATH

alias dots='/usr/bin/git --git-dir=$HOME/.dots/.git/ --work-tree=$HOME'
