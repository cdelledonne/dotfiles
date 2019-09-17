# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/cdelledonne/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# End of lines configured by zsh-newuser-install

# Complete './' and '../'
zstyle ':completion:*' special-dirs true

# Enable themes
autoload -Uz promptinit
promptinit

# Prompt
PS1='[%B%F{green}%1~%f%b] $ '

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -al'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
