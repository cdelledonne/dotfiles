# export PS1="\[\033[32;1m\]\u\[\033[m\][\[\033[36;1m\]\W\[\033[m\]]\$ "
export PS1="\[\033[32;1m\]\u\[\033[m\] \$ "
# export PS1="\[\033[32;1m\]\u\[\033[32;1m\]@\[\033[32;1m\]\h\[\033[m\]:\[\033[36;1m\]\w\[\033[m\]\$ "

export PATH=/usr/local/bin:$PATH:/Users/Carlo/Developer/Scripts

# Use Homebrew's curl
export PATH=/usr/local/opt/curl/bin:$PATH

# git autocompletion script
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Case-insensitive bash completion
bind "set completion-ignore-case on"

# Avoid pressing Tab twice when there is more than one match for autocompletion
bind "set show-all-if-ambiguous on"

# Path for Python's import and start-up routine
export PYTHONPATH=/Users/Carlo/Developer/Python/packages
export PYTHONSTARTUP=~/.pythonrc

# For Vim
export VIMRC=/Users/Carlo/.vimrc

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

alias ll='ls -la'
alias sshpi='ssh -p 10022 pi@cdelledonne.dynu.com'
alias p3='python3'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
