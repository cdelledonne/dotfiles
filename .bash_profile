export PS1="\[\033[32;1m\]\u\[\033[m\]:[\[\033[36;1m\]\W\[\033[m\]]\$ "
# export PS1="\[\033[32;1m\]\u\[\033[m\]:\[\033[36;1m\]\W\[\033[m\]\$ "
# export PS1="\[\033[32;1m\]\u\[\033[32;1m\]@\[\033[32;1m\]\h\[\033[m\]:\[\033[36;1m\]\w\[\033[m\]\$ "
# export PS1="\[\033[32;1m\]☕ \[\033[m\] "

export PATH=/usr/local/bin:$PATH:/Users/Carlo/Developer/Scripts

# Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.3.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# git autocompletion script
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Case-insensitive bash completion
bind "set completion-ignore-case on"

# Avoid pressing Tab twice when there is more than one match for autocompletion
bind "set show-all-if-ambiguous on"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

alias sshpi='ssh -p 10022 pi@cdelledonne.dynu.com'
alias p3='python3'
