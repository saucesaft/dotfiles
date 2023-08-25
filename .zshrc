export ZSH="/Users/saucesaft/.oh-my-zsh"
ZSH_THEME="geometry/geometry"

plugins=(virtualenv git)

mamba_prompt() {
    printenv CONDA_DEFAULT_ENV
}


GEOMETRY_RPROMPT+=( mamba_prompt )

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# export local path
export PATH=$PATH:~/bin

# zsh shell stuff
source $ZSH/oh-my-zsh.sh

# Latex dvisvgm stuff
export LIBGS="/opt/homebrew/lib/libgs.dylib"

# Rust Stuff
source $HOME/.cargo/env

# Nintendo Homebrew Compilers
export DEVKITPRO=/opt/devkitpro
export DEVKITARM="${DEVKITPRO}/devkitARM"
export DEVKITPPC="${DEVKITPRO}/devkitPPC"
export PATH="${DEVKITPRO}/tools/bin:${PATH}"
export PATH="${DEVKITPRO}/devkitPPC/bin:${PATH}"

# ROS2 stuff
export OPENSSL_ROOT_DIR=$(brew --prefix openssl)

# Tools for Android Hacking woooo
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home

export PATH=~/Library/Android/sdk/platform-tools/:$PATH
export PATH=~/Library/Android/sdk/cmdline-tools/latest/bin/:$PATH

# PSX Homebrew Compilers and Utilities
export PATH=$PATH:/opt/mipsel-none-elf/bin:/opt/PSn00bSDK/bin

# Homebrew Installed Packages on pkg-config
export PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig:/usr/local/lib:/opt/homebrew/opt/zlib/lib/pkgconfig:/opt/homebrew/opt/curl/lib/pkgconfig
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# Pebble SDK
export PATH=$PATH:/Users/saucesaft/Documents/pebble-sdk-4.5-mac/bin

# PyEnv Stuff
export PATH=$(pyenv root)/shims:$PATH

alias dots='/usr/bin/git --git-dir=$HOME/.dots/.git/ --work-tree=$HOME'

export PATH=$PATH:/Users/saucesaft/.spicetify

alias mm="micromamba"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/opt/homebrew/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/saucesaft/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/saucesaft/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/saucesaft/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/saucesaft/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
source ${HOME}/.ghcup/env
