export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=/opt/homebrew/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=99999
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt correct
setopt no_beep
setopt nonomatch

# completion
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed
zstyle ':completion:*' list-colors ''
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(kubectl completion zsh)

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
PROMPT='%T %~ %F{magenta}$%f '
RPROMPT='${vcs_info_msg_0_}'

alias ls='ls -aFG'
alias ll='ls -lh'
alias vi='vim'
alias his='history'
alias cat='bat -pP'
alias less='less -NM'
alias diff='colordiff'
alias df='df -h'
alias k='kubectl'

# peco
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
