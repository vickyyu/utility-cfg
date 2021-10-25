#!/bin/sh

if [ ! -d $HOME/.oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [ ! -d $HOME/spacemacs ]; then
	git clone https://github.com/syl20bnr/spacemacs $HOME/spacemacs
fi
if [ ! -d $HOME/env/emacs.d ]; then
	git clone https://github.com/vickyyu/emacs.d -b os-mac-v1 $HOME/env/emacs.d
fi
if [ ! -d $HOME/.tmux/plugins ]; then
	mkdir -p $HOME/.tmux/plugins
fi
if [ ! -d $HOME/.tmux/plugins/tmux-sensible ]; then
	git clone https://git::@github.com/plugins/tmux-sensible $HOME/.tmux/plugins/tmux-sensible
fi
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
	git clone https://github.com/plugins/tpm $HOME/.tmux/plugins/tpm
fi
if [ ! -d $HOME/.tmux/tmux-plugins/tmux-resurrect ]; then
	git clone https://git::@github.com/plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect
fi
if [ ! -L $HOME/.emacs.d ]; then
	ln -s $HOME/spacemacs $HOME/.emacs.d
fi
if [ ! -L $HOME/.spacemacs ]; then
	ln -s $HOME/env/utility-cfg/.spacemacs.develop $HOME/.spacemacs
fi
if [ ! -L $HOME/.bash_completion.d ]; then
	ln -s $HOME/env/utility-cfg/.bash_completion.d $HOME/.bash_completion.d
fi
if [ ! -L $HOME/.bashrc ]; then
	ln -s $HOME/env/utility-cfg/.bashrc $HOME/.bashrc
fi
if [ ! -L $HOME/.screenrc ]; then
	ln -s $HOME/env/utility-cfg/.screenrc $HOME/.screenrc
fi
if [ ! -L $HOME/.tmux.conf ]; then
	ln -s $HOME/env/utility-cfg/.tmux.conf $HOME/.tmux.conf
fi
if [ ! -L $HOME/.vim ]; then
	ln -s $HOME/env/utility-cfg/vim/.vim $HOME/.vim
fi
if [ ! -L $HOME/.vimrc ]; then
	ln -s $HOME/env/utility-cfg/vim/.vimrc $HOME/.vimrc
fi
if [ ! -L $HOME/.zshrc ]; then
	ln -s $HOME/env/utility-cfg/.zshrc $HOME/.zshrc
fi
