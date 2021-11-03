#!/bin/sh

[ ! -L $HOME/.bashrc ] && ln -s $HOME/env/utility-cfg/.bashrc $HOME/.bashrc
[ ! -L $HOME/.screenrc ] && ln -s $HOME/env/utility-cfg/.screenrc $HOME/.screenrc
[ ! -d $HOME/bin ] && mkdir $HOME/bin
[ ! -f $HOME/bin/csgen.sh ] && ln -s $HOME/env/utility-cfg/csgen.sh $HOME/bin/csgen.sh

# ZSH
if [ ! -d $HOME/.oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
[ ! -L $HOME/.zshrc ] && ln -s $HOME/env/utility-cfg/.zshrc $HOME/.zshrc

# spacemacs
[ ! -d $HOME/spacemacs ] && git clone https://github.com/syl20bnr/spacemacs $HOME/spacemacs
#[ ! -d $HOME/env/emacs.d ] && git clone https://github.com/vickyyu/emacs.d -b os-mac-v1 $HOME/env/emacs.d
[ ! -L $HOME/.emacs.d ] &&ln -s $HOME/spacemacs $HOME/.emacs.d
[ ! -L $HOME/.spacemacs ] && ln -s $HOME/env/utility-cfg/.spacemacs.develop.26.3 $HOME/.spacemacs

# tmux & tmux plugin
[ ! -L $HOME/.tmux.conf ] && ln -s $HOME/env/utility-cfg/.tmux.conf $HOME/.tmux.conf
[ ! -d $HOME/.tmux/plugins ] && mkdir -p $HOME/.tmux/plugins
[ ! -d $HOME/.tmux/plugins/tmux-sensible ] && git clone https://git::@github.com/plugins/tmux-sensible $HOME/.tmux/plugins/tmux-sensible
[ ! -d $HOME/.tmux/plugins/tpm ] && git clone https://github.com/plugins/tpm $HOME/.tmux/plugins/tpm
[ ! -d $HOME/.tmux/plugins/tmux-resurrect ] && git clone https://git::@github.com/plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect
[ ! -L $HOME/.bash_completion.d ] && ln -s $HOME/env/utility-cfg/.bash_completion.d $HOME/.bash_completion.d

# vim
[ ! -L $HOME/.vim ] && ln -s $HOME/env/utility-cfg/vim $HOME/.vim
[ ! -L $HOME/.vimrc ] && ln -s $HOME/env/utility-cfg/vim/.vimrc $HOME/.vimrc

