HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

alias ls='ls -aFG'
alias ll='ls -lh'
alias vi='vim'
alias his='history'
alias less='less -NM'
alias diff='colordiff'
alias df='df -h'
alias brewout='brew outdated && brew cask outdated'
