# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.aliasrc ]; then
   . ~/.aliasrc
fi

# for git
alias 'gd'='git diff --color'
alias 'glg'='git log --color --name-only --decorate'
alias 'glog'='git log --pretty=format:'%h:%s:%d' --topo-order --graph'
alias 'gs'='git show --color'
alias 'grh'='git reset --hard'
alias 'grs'='git reset --soft'
alias 'gac'='git add -u;git commit'

# include git-completion
. ~/.bash_completion.d/git-completion.bash
. ~/.bash_completion.d/docker-completion.sh
. ~/.bash_completion.d/docker-machine-completion.sh
. ~/.bash_completion.d/docker-compose-completion.sh

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;35m\]$(__git_ps1)\[\033[m\]\$'

# set the tab title of iTerm
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007"'
