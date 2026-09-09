export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=/opt/homebrew/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export KUBECTL_EXTERNAL_DIFF=colordiff

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
source $(brew --prefix)/etc/zsh-kubectl-prompt/kubectl.zsh
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
PROMPT='%T %~ %(?.%F{magenta}$.%F{red}$)%f '
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

function peco-kubectl-context() {
  local selected_context=$(kubectl config view -o go-template --template='{{range .contexts}}{{.name}}{{"\n"}}{{end}}' | peco --query "$LBUFFER")
  if [ -n "$selected_context" ]; then
    BUFFER="kubectl config use-context $selected_context"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-kubectl-context
bindkey '^k' peco-kubectl-context
