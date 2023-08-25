## saucesaft's dotfiles

hi! welcome, enjoy :)

### setup

1. `git init --bare $HOME/.dots`
2. `alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'`
3. `dotfiles config --local status.showUntrackedFiles no`

### clone

1. `git clone --bare <git-repository-url> $HOME/.dots`
2. `alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'`
3. `dots checkout`
4. `dots config --local status.showUntrackedFiles no`

### update 

1. `dots status`
2. `dots add .vimrc` or `dot add ./config/nvim/init.vim`
3. `dots add .bashrc`
4. `dots commit -m "Add dotfiles"`
5. `dots push`
