#!/bin/bash

################################################################################
# Configuration directories (Vim and Neovim)                                   #
################################################################################

# Colors
RED='\033[1;31m'   # Bold red
GREEN='\033[1;32m' # Bold green
NC='\033[0m'       # No color

# Default directories
VIM_CONFIG_DIR="$HOME/.vim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
ALACRITTY_CONFIG="$HOME/.config/alacritty"

echo ""
echo "General configuration"
echo "====================="
echo ""
echo -e "* ${RED}Use absolute pahts.${NC}"
echo "* Default options are shown in square brackets, return empty answers to use them."

vim_config_dir_done=0
nvim_config_dir_done=0

# Set Vim configuration directory
while [ $vim_config_dir_done -eq 0 ]
do
    # Ask the user whether they want to use something different than the default
    echo ""
    read -e -p "Vim configuration directory [ $VIM_CONFIG_DIR ]: " input_vim_config_dir
    # Check if the user wants to use the default directory
    if [ -z $input_vim_config_dir ]
    then
        # Check if default directory does not exist and has to be created
        if ! [ -d $VIM_CONFIG_DIR ]
        then
            mkdir -p $VIM_CONFIG_DIR
        fi
        # Terminate loop
        vim_config_dir_done=1
    # The user wants to use a non-default directory
    else
        # Check if the specified directory exists
        if [ -d $input_vim_config_dir ]
        then
            # Terminate loop
            VIM_CONFIG_DIR=$input_vim_config_dir
        else
            # The specified directory does not exist
            while [ 1 ]
            do
                # Ask the user whether they want to create it
                read -p "Directory $input_vim_config_dir does not exist, create? (y/n): " create_dir
                # Check if the user wants to create a new directory
                if [ $create_dir = "y" ] || [ $create_dir = "Y" ]
                then
                    # Create directory and terminate loop
                    VIM_CONFIG_DIR=$input_vim_config_dir
                    mkdir -p $VIM_CONFIG_DIR
                    vim_config_dir_done=1
                    break
                elif [ $create_dir = "n" ] || [ $create_dir = "N" ]
                then
                    # The user does not want to create the new directory, ask for a different one
                    break
                fi
            done
        fi
    fi
done

# Set Neovim configuration directory
while [ $nvim_config_dir_done -eq 0 ]
do
    # Ask the user whether they want to use something different than the default
    echo ""
    read -e -p "Neovim configuration directory [ $NVIM_CONFIG_DIR ]: " input_nvim_config_dir
    # Check if the user wants to use the default directory
    if [ -z $input_nvim_config_dir ]
    then
        # Check if default directory does not exist and has to be created
        if ! [ -d $NVIM_CONFIG_DIR ]
        then
            mkdir -p $NVIM_CONFIG_DIR
        fi
        # Terminate loop
        nvim_config_dir_done=1
    # The user wants to use a non-default directory
    else
        # Check if the specified directory exists
        if [ -d $input_nvim_config_dir ]
        then
            # Terminate loop
            NVIM_CONFIG_DIR=$input_nvim_config_dir
        else
            # The specified directory does not exist
            while [ 1 ]
            do
                # Ask the user whether they want to create it
                read -p "Directory $input_nvim_config_dir does not exist, create? (y/n): " create_dir
                # Check if the user wants to create a new directory
                if [ $create_dir = "y" ] || [ $create_dir = "Y" ]
                then
                    # Create directory and terminate loop
                    NVIM_CONFIG_DIR=$input_nvim_config_dir
                    mkdir -p $NVIM_CONFIG_DIR
                    nvim_config_dir_done=1
                    break
                elif [ $create_dir = "n" ] || [ $create_dir = "N" ]
                then
                    # The user does not want to create the new directory, ask for a different one
                    break
                fi
            done
        fi
    fi
done

echo ""

################################################################################
# Dotfiles installation                                                        #
################################################################################

# List of non-dotfiles
NON_DOTFILES=(
    ".DS_Store"
    ".git"
    ".gitmodules"
    "install."*
    *".md"
    "__pycache__"
)

# Helper function to check whether input string does not match (part of)
# a string in an array of string
elementNotIn () {
    local e match="$1"
    shift
    for e; do [[ $match == $e ]] && return 1; done
    return 0
}

echo ""
echo "Dotfiles installation"
echo "====================="
echo ""
echo -e "* ${RED}Use absolute pahts.${NC}"
echo "* Default options are shown in square brackets, return empty answers to use them."

# Loop through files in current directory
for f in `find $PWD/ -maxdepth 1 -not -path $PWD/`
do
    # Extract basename of file
    filename=$(basename $f)
    # Filter out non-dotfiles
    if elementNotIn "$filename" "${NON_DOTFILES[@]}"
    then
        # Ask the user whether to install (symlink) this dotfile
        echo ""
        read -p "$(echo -e "Install ${GREEN}${filename}${NC}? (y/n): ")" install_df
        if [ $install_df = "y" ] || [ $install_df = "Y" ]
        then
            # Default destinations
            case $filename in
                "init.vim"|"init-server.vim"|"coc-config.json"|"settings.json") dst=$NVIM_CONFIG_DIR/;;
                "alacritty.yml") dst=$ALACRITTY_CONFIG_DIR/;;
                *) dst=$HOME;;
            esac
            # Ask the user whether to use something different than the default
            while [ 1 ]
            do
                read -e -p "Destination [ $dst ]: " input_dst
                if ! [ -z $input_dst ]
                then
                    test_dst=$input_dst
                else
                    test_dst=$dst
                fi
                if [ -e $test_dst ]
                then
                    dst=$test_dst
                    break
                fi
                echo "ERROR: '$test_dst' is not a valid path"
            done
            # Check if target already exists
            case $filename in
                "init-server.vim") target=$dst/init.vim;;
                *) target=$dst/$filename;;
            esac
            if [ -e $target ]
            then
                # Ask the user whether to revise the file, in case target is not a directory
                if ! [ -d $target ]
                then
                    read -p "File already exists, open for revision? (y/n): " open_target
                    if [ $open_target = "y" ] || [ $open_target = "Y" ]
                    then
                        edit $target
                    fi
                fi
                # Ask the user whether to override the existing target
                read -p "File already exists, override? (y/n): " override_target
                if [ $override_target = "y" ] || [ $override_target = "Y" ]
                then
                    # Remove existing target
                    rm -rf $target
                    # Create link
                    ln -s $f $target
                    echo "$target -> $f"
                fi
            # Otherwise, just create the link
            else
                ln -s $f $target
                echo "$target -> $f"
            fi
        fi
    fi
done

################################################################################
# Neovim links to Vim subdirectories                                           #
################################################################################

# Vim subdirectories to be linked to Neovim config directory
VIM_SUBDIRS=(
    "pythonx"
    "spell"
    "syntax"
    "ultisnips"
    "lua"
)

# Helper function to check whether input string matches (part of)
# a string in an array of string
elementIn () {
    local e match="$1"
    shift
    for e; do [[ $match == $e ]] && return 0; done
    return 1
}

echo ""
echo "Neovim links to Vim subdirectories"
echo "=================================="

for f in `find $VIM_CONFIG_DIR/ -maxdepth 1 -not -path $VIM_CONFIG_DIR/`
do
    # Extract basename of file
    dirname=$(basename $f)
    # Filter out non-dotfiles
    if elementIn "$dirname" "${VIM_SUBDIRS[@]}"
    then
        # Ask the user whether to symlink this subdirectory
        echo ""
        read -p "$(echo -e "Link ${GREEN}${dirname}${NC} to Neovim's config directory? (y/n): ")" link_sd
        if [ $link_sd = "y" ] || [ $link_sd = "Y" ]
        then
            # Check if target already exists
            target=$NVIM_CONFIG_DIR/$dirname
            if [ -e $target ]
            then
                # Ask the user whether to override the existing target
                if [ -L $target ]
                then
                    read -p "Link already exists, override? (y/n): " override_link
                else
                    read -p "File already exists, delete? (y/n): " override_link
                fi
                if [ $override_link = "y" ] || [ $override_link = "Y" ]
                then
                    # Remove existing target
                    rm -rf $target
                    # Create link
                    ln -s $f $target
                fi
            # Otherwise, just create the link
            else
                ln -s $f $target
            fi
        fi
    fi
done

################################################################################
# Installation of Oh My Zsh                                                    #
################################################################################

echo ""
echo "Installation of Oh My Zsh"
echo "========================="

echo ""
read -p "$(echo -e "Install ${GREEN}Oh My Zsh${NC}? (y/n): ")" install_omz
if [ $install_omz = "y" ] || [ $install_omz = "Y" ]
then
    # Install Oh My Zsh
    export CHSH=no
    export RUNZSH=no
    export REPLACE_RC=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Bypass some internals
    mkdir -p $HOME/.oh-my-zsh/custom/lib
    touch $HOME/.oh-my-zsh/custom/lib/bzr.zsh
    touch $HOME/.oh-my-zsh/custom/lib/clipboard.zsh
    touch $HOME/.oh-my-zsh/custom/lib/compfix.zsh
    touch $HOME/.oh-my-zsh/custom/lib/completion.zsh
    touch $HOME/.oh-my-zsh/custom/lib/correction.zsh
    touch $HOME/.oh-my-zsh/custom/lib/diagnostics.zsh
    touch $HOME/.oh-my-zsh/custom/lib/directories.zsh
    touch $HOME/.oh-my-zsh/custom/lib/history.zsh
    touch $HOME/.oh-my-zsh/custom/lib/key-bindings.zsh
    touch $HOME/.oh-my-zsh/custom/lib/misc.zsh
    touch $HOME/.oh-my-zsh/custom/lib/nvm.zsh
    touch $HOME/.oh-my-zsh/custom/lib/prompt_info_functions.zsh
    touch $HOME/.oh-my-zsh/custom/lib/spectrum.zsh
    touch $HOME/.oh-my-zsh/custom/lib/termsupport.zsh
fi

echo ""

################################################################################
# Installation of vim-plug                                                     #
################################################################################

echo ""
echo "Installation of vim-plug"
echo "========================"

echo ""
read -p "$(echo -e "Install ${GREEN}vim-plug${NC}? (y/n): ")" install_vp
if [ $install_vp = "y" ] || [ $install_vp = "Y" ]
then
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo ""

################################################################################
# Installation of Tmux Plugin Manager                                          #
################################################################################

echo ""
echo "Installation of Tmux Plugin Manager"
echo "==================================="

echo ""
read -p "$(echo -e "Install ${GREEN}TPM${NC}? (y/n): ")" install_tmp
if [ $install_tmp = "y" ] || [ $install_tmp = "Y" ]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo ""
