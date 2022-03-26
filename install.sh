#!/usr/bin/env bash

################################################################################

# Script constants
SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
OPTSTRING=":e:i:yflh"

# Error codes
ERROR_MISSING_ARG=1
ERROR_INVALID_OPT=2
ERROR_CLASHING_OPTS=3
ERROR_INVALID_DOTFILE=4

# Default script behavior
declare -a exclude
declare -a include
assumeyes=false
force=false

# Default directories
confdir=${CONFDIR:-$HOME/.config}
datadir=${DATADIR:-$HOME/.local/share}

# Default dotfiles and destination paths
declare -A dotfiles
dotfiles["alacritty"]="$confdir"
dotfiles["fontconfig"]="$confdir"
dotfiles["git"]="$confdir"
dotfiles["gitmux"]="$confdir"
dotfiles["nvim"]="$confdir"
dotfiles["tmux"]="$confdir"
dotfiles[".zshrc"]="$HOME"

# Default plugins and destination paths
declare -A plugins
plugins["vim-plug"]="$datadir/nvim/site/autoload/plug.vim"
plugins["tpm"]="$datadir/tmux/plugins/tpm"

# Dotfiles and plugins to actually install
declare -A selected_dotfiles
declare -A selected_plugins
for key in "${!dotfiles[@]}"; do
    selected_dotfiles["$key"]="${dotfiles[$key]}"
done
for key in "${!plugins[@]}"; do
    selected_plugins["$key"]="${plugins[$key]}"
done

################################################################################

exit_with_code () {
    echo ""
    exit $1
}

echo_usage () {
    echo "Install dotfiles (create symlinks) and additional plugins."
    echo ""
    echo "Usage:"
    echo "  $(basename $0) [options]"
    echo ""
    echo "Options:"
    echo "  -e, --exclude <dotfile>    exclude dotfile/plugin (can be passed multiple times)"
    echo "  -i, --include <dotfile>    include dotfile/plugin (can be passed multiple times)"
    echo "  -y, --assumeyes            do not prompt for confirmation"
    echo "  -f, --force                overwrite existing symlinks (when passing '-y')"
    echo "  -l, --list                 list available dotfiles and plugins"
    echo "  -h, --help                 show this help message"
}

echo_missing_arg_error () {
    echo "Error: must supply an argument to option '-$1'." >&2
    echo "Try '$SCRIPT_NAME --help' for more information."
}

echo_invalid_opt_error () {
    echo "Error: invalid option: '-$1'." >&2
    echo "Try '$SCRIPT_NAME --help' for more information."
}

echo_clashing_opts_error () {
    echo "Options '-$1' and '-$2' cannot be used together." >&2
}

echo_invalid_dotfile_error () {
    echo "Invalid dotfile or plugin name '$1'." >&2
    echo "Try '$SCRIPT_NAME --list' to list available dotfiles and plugins."
}

echo_dotfiles_and_plugins () {
    echo "Dotfile             Destination"
    echo "--------------------------------------------------------------------------------"
    for key in "${!dotfiles[@]}"; do
        printf "%-20s%s\n" $key ${dotfiles[$key]}
    done
    echo ""
    echo "Plugin              Destination"
    echo "--------------------------------------------------------------------------------"
    for key in "${!plugins[@]}"; do
        printf "%-20s%s\n" $key ${plugins[$key]}
    done
}

echo_selected_dotfiles_and_plugins () {
    echo "Selected dotfile    Destination"
    echo "--------------------------------------------------------------------------------"
    for key in "${!selected_dotfiles[@]}"; do
        printf "%-20s%s\n" "$key" "${selected_dotfiles[$key]}"
    done
    echo ""
    echo "Selected plugin     Destination"
    echo "--------------------------------------------------------------------------------"
    for key in "${!selected_plugins[@]}"; do
        printf "%-20s%s\n" "$key" "${selected_plugins[$key]}"
    done
}

parse_args () {
    # Transform long options to short ones
    for arg in "$@"; do
        shift
        case "$arg" in
            "--exclude") set -- "$@" "-e" ;;
            "--include") set -- "$@" "-i" ;;
            "--assumeyes") set -- "$@" "-y" ;;
            "--force") set -- "$@" "-f" ;;
            "--list") set -- "$@" "-l" ;;
            "--help") set -- "$@" "-h" ;;
            *) set -- "$@" "$arg"
        esac
    done
    # Parse command-line options
    while getopts "$OPTSTRING" arg; do
        case "$arg" in
            "e") exclude+=( $OPTARG ) ;;
            "i") include+=( $OPTARG ) ;;
            "y") assumeyes=true ;;
            "f") force=true ;;
            "l") echo_dotfiles_and_plugins; exit_with_code 0 ;;
            "h") echo_usage; exit_with_code 0 ;;
            ":") echo_missing_arg_error "$OPTARG"; exit_with_code $ERROR_MISSING_ARG ;;
            "?") echo_invalid_opt_error "$OPTARG"; exit_with_code $ERROR_INVALID_OPT ;;
        esac
    done
}

exclude_dotfiles_and_plugins () {
    for exclude in "$@"; do
        if [[ -v dotfiles["$exclude"] ]]; then
            unset selected_dotfiles["$exclude"]
        elif [[ -v plugins["$exclude"] ]]; then
            unset selected_plugins["$exclude"]
        else
            echo_invalid_dotfile_error "$exclude"
            exit_with_code $ERROR_INVALID_DOTFILE
        fi
    done
}

include_dotfiles_and_plugins () {
    selected_dotfiles=()
    selected_plugins=()
    for include in "$@"; do
        if [[ -v dotfiles["$include"] ]]; then
            selected_dotfiles["$include"]="${dotfiles[$include]}"
        elif [[ -v plugins["$include"] ]]; then
            selected_plugins["$include"]="${plugins[$include]}"
        else
            echo_invalid_dotfile_error "$include"
            exit_with_code $ERROR_INVALID_DOTFILE
        fi
    done
}

install_dotfiles () {
    for key in "${!selected_dotfiles[@]}"; do
        dotfile="$key"
        source="$SCRIPT_DIR/$dotfile"
        target="${selected_dotfiles[$key]}/$dotfile"

        # If target exists (it's either a link or a regular file or directory),
        # skip this dotfiles, unless the user has passed the option '-f'
        if [ -L "$target" ] || [ -e "$target" ]; then
            if [ $force == false ]; then
                echo "Note: target '$target' exists, skipping dotfile '$dotfile'."
                continue
            fi
            rm -rf "$target"
        fi

        # Make sure parent directory of target exists
        mkdir -p "${selected_dotfiles[$key]}"

        # Create a symlink to source at target
        ln -s "$source" "$target"
    done
}

install_plugins () {
    for key in "${!selected_plugins[@]}"; do
        plugin="$key"
        target="${selected_plugins[$key]}"

        # If target exists (it's either a link or a regular file or directory),
        # skip this plugin, unless the user has passed the option '-f'
        if [ -L "$target" ] || [ -e "$target" ]; then
            if [ $force == false ]; then
                echo "Note: target '$target' exists, skipping plugin '$plugin'."
                continue
            fi
            rm -rf "$target"
        fi

        case "$plugin" in
            "vim-plug")
                curl -fLo "$target" --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                ;;
            "tpm")
                git clone https://github.com/tmux-plugins/tpm "$target"
                ;;
        esac
    done
}

################################################################################

main () {
    parse_args "$@"

    # Sanity check: cannot pass '-e' and '-i' together
    if [ ${#exclude[@]} -gt 0 ] && [ ${#include[@]} -gt 0 ]; then
        echo_clashing_opts_error "e" "i"
        exit_with_code $ERROR_CLASHING_OPTS
    fi

    if [ ${#exclude[@]} -gt 0 ]; then
        exclude_dotfiles_and_plugins "${exclude[@]}"
    elif [ ${#include[@]} -gt 0 ]; then
        include_dotfiles_and_plugins "${include[@]}"
    fi

    echo_selected_dotfiles_and_plugins

    # Ask the user whether to install the selected dotfiles and plugins, unless
    # the user has already passed the option '-y'
    if [ $assumeyes == false ]; then
        echo ""
        read -p "Install selected dotfiles and plugins? (y/n): " rsp
        if ! [ "$rsp" == "y" ] && ! [ "$rsp" == "Y" ]; then
            exit_with_code 0
        fi
    fi

    install_dotfiles

    install_plugins

    exit_with_code 0
}

main "$@"
