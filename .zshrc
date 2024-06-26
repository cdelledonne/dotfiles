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

# Workaround for some systems that define a custom LS_COLORS
unset LS_COLORS

# PATH
export PATH=~/.local/bin:$PATH

# Wayland-related
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
fi

export EDITOR=nvim
export MANPAGER='nvim +Man!'
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

alias kssh='kitten ssh'

################################################################################
# Add-ons                                                                      #
################################################################################

[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

export FZF_DEFAULT_OPTS="\
--reverse \
--color bg+:#1d2021,bg:#1d2021,border:#83a598,spinner:#928374,hl:#fe8019 \
--color fg:#928374,header:#928374,info:#928374,pointer:#83a598 \
--color marker:#b8bb26,fg+:#b8bb26,prompt:#83a598,hl+:#fe8019"

[ -x "$(command -v rg)" ] && export FZF_DEFAULT_COMMAND="rg \
--files \
--hidden \
--follow \
--no-messages \
--no-ignore-global \
--glob \
'!.git/*' \
--glob \!'* *'"

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
# Prompt                                                                       #
################################################################################

# Prompt, part 1: hostname, only if in an ssh session
if [[ "$SSH_CONNECTION" == "" ]]; then
    PROMPT=''
else
    PROMPT='{%B%F{magenta}%m%f%b} '
fi

# Prompt, part 2: current directory (not full path)
PROMPT+='[%B%F{yellow}%1~%f%b] '

# Prompt, part 4: dollar sign
PROMPT+='$ '
