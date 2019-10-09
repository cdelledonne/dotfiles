################################################################################
# Things to do before compinit                                                 #
################################################################################

# Homebrew autocompletion (must be called before compinit)
if [[ "$(uname)" == "Darwin" ]]; then
    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    fi
fi

################################################################################
# Automatic settings                                                           #
################################################################################

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

################################################################################
# Other completion settings                                                    #
################################################################################

# Complete './' and '../'
zstyle ':completion:*' special-dirs true

################################################################################
# Environment                                                                  #
################################################################################

# PATH
export PATH=~/.local/bin:$PATH

# Wayland-related
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
fi

################################################################################
# Aliases                                                                      #
################################################################################

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='gls --color=auto --group-directories-first'
else
    alias ls='ls --color=auto --group-directories-first'
fi
alias ll='ls -Fhl'
alias la='ls -FhAl'

################################################################################
# Add-ons                                                                      #
################################################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

################################################################################
# Oh My Zsh                                                                    #
################################################################################

export ZSH=$HOME/.oh-my-zsh
DISABLE_LS_COLORS="true"
ZSH_DISABLE_COMPFIX="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Prompt, part 1: aostname, only if in an ssh session
if [[ "$SSH_CONNECTION" == "" ]]; then
    PROMPT=''
else
    PROMPT='{%B%F{magenta}$(hostname)%f%b} '
fi

# Prompt, part 2: current directory (not full path)
PROMPT+='[%B%F{yellow}%1~%f%b] '

# Prompt, part 3: Git branch and dirty status
PROMPT+='$(git_prompt_info)'

# Prompt, part 4: dollar sign
PROMPT+='$ '

# Theme of the Git prompt info
ZSH_THEME_GIT_PROMPT_PREFIX="(%B%F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b) "
ZSH_THEME_GIT_PROMPT_DIRTY="%B%F{red} *%f%b"
ZSH_THEME_GIT_PROMPT_CLEAN=""
