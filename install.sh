#!/bin/bash

# Default directories
CONFDIR=${CONFDIR:-~/.config}

# Dotfiles to link
declare -a dotfiles=(
    "alacritty"         "$CONFDIR"
    "bat"               "$CONFDIR"
    "gitmux"            "$CONFDIR"
    "nvim"              "$CONFDIR"
    "fontconfig"        "$CONFDIR"
    ".gitconfig"        "$HOME"
    ".gitignore_global" "$HOME"
    ".pythonrc"         "$HOME"
    ".tmux.conf"        "$HOME"
    ".zshrc"            "$HOME"
)

################################################################################

echo ""
echo "Installation of dotfiles"
echo "========================"
echo ""

# Loop through dotfile-destination pairs
for (( index=0; index<${#dotfiles[@]}; index+=2 )); do

    DOTFILE=${dotfiles[index]}
    SRC=$PWD/$DOTFILE
    TRG=${dotfiles[index+1]}/$DOTFILE

    # Ask the user whether to install this dotfile
    read -p "Install '$DOTFILE' at '$TRG'? (y/n): " rsp
    ! ([[ $rsp = "y" ]] || [[ $rsp = "Y" ]]) && continue

    # If target exists, ask the user whether to overwrite
    if [ -e $TRG ]
    then
        read -p "'$TRG' exists, overwrite? (y/n): " rsp
        ! ([[ $rsp = "y" ]] || [[ $rsp = "Y" ]]) && continue
        rm -rf $TRG
    fi

    # Create a symlink to SRC at TRG
    ln -s $SRC $TRG
done

################################################################################

echo ""
echo "Installation of other plugins"
echo "============================="
echo ""

# Ask the user whether to install vim-plug (inside Neovim's RTP)
read -p "Install 'vim-plug'? (y/n): " rsp
if [ $rsp = "y" ] || [ $rsp = "Y" ]
then
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Ask the user whether to install Tmux Plugin Manager
echo ""
read -p "Install 'Tmux Plugin Manager'? (y/n): " rsp
if [ $rsp = "y" ] || [ $rsp = "Y" ]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
