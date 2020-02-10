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

export EDITOR=nvim
export BAT_THEME=gruvbox

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

export FZF_DEFAULT_OPTS="
    --color bg+:#282828,bg:#282828,border:#83a598,spinner:#928374,hl:#fe8019
    --color fg:#928374,header:#928374,info:#928374,pointer:#83a598
    --color marker:#b8bb26,fg+:#b8bb26,prompt:#83a598,hl+:#fe8019
"

# Taken from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey -M emacs '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line

################################################################################
# Oh My Zsh                                                                    #
################################################################################

# export ZSH=$HOME/.oh-my-zsh
# DISABLE_LS_COLORS="true"
# ZSH_DISABLE_COMPFIX="true"
# plugins=(sudo)
# source $ZSH/oh-my-zsh.sh

# Theme of the Git prompt info
# ZSH_THEME_GIT_PROMPT_PREFIX="(%B%F{blue}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b) "
# ZSH_THEME_GIT_PROMPT_DIRTY="%B%F{red} *%f%b"
# ZSH_THEME_GIT_PROMPT_CLEAN=""

################################################################################
# Prompt                                                                       #
################################################################################

# Prompt, part 1: hostname, only if in an ssh session
if [[ "$SSH_CONNECTION" == "" ]]; then
    PROMPT=''
else
    PROMPT='{%B%F{magenta}$(hostname)%f%b} '
fi

# Prompt, part 2: current directory (not full path)
PROMPT+='[%B%F{yellow}%1~%f%b] '

# Prompt, part 3: Git branch and dirty status (NEEDS Oh My Zsh)
# PROMPT+='$(git_prompt_info)'

# Prompt, part 4: dollar sign
PROMPT+='$ '
