#!/usr/local/bin/python3

import os
import subprocess
import readline
import glob

# Get CWD and HOME
CWD  = os.getcwd()
HOME = os.path.expanduser('~')

# Non-dotfiles
NON_DOTFILES = [
    '.DS_Store',
    '.git',
    '.gitmodules',
    'install.py',
    'README.md',
    '__pycache__'
]


def pathCompleter(text, state):
    """
    Tab-triggered path autocompletion.
    Source: https://gist.github.com/iamatypeofwalrus/5637895
    """
    # Expand tilde
    if '~' in text:
        text = text.replace('~', os.path.expanduser('~'))
    # Get completion candidate
    candidate = [x for x in glob.glob(text + '*')][state]
    # Append slash if candidate is a directory
    if os.path.isdir(candidate):
        candidate += '/'
    return candidate


if __name__ == '__main__':

    # Set path autocompletion
    readline.set_completer_delims('\t')
    readline.parse_and_bind("tab: complete")
    readline.set_completer(pathCompleter)

    # List of dotfiles
    dotfiles = os.listdir()

    # Remove non-dotfiles
    dotfiles = [d for d in dotfiles if d not in NON_DOTFILES]

    # Remove possible Vim swap files
    dotfiles = [d for d in dotfiles if not d.endswith(('.swp', '.swo'))]

    try:
        # Install (symlink) dotfiles
        print("Installing dotfiles...")
        for df in dotfiles:

            # Give the user the option to skip dotfile
            install_df = input(">> Install '{:s}'? (y/n): ".format(df))
            if install_df.lower() == 'y':

                # Get destination path from the user
                while True:
                    dst_path = input("   >> destination (empty for '{:s}'): ".format(HOME))
                    if dst_path == '':
                        dst_path = HOME
                    dst_path_abs = os.path.abspath(dst_path)
                    if os.path.isdir(dst_path_abs):
                        break
                    print("      >> '{:s}' is not a valid path".format(dst_path_abs))

                # Formulate source and destination of the symbolic link
                src = os.path.join(CWD, df)
                dst = os.path.join(dst_path_abs, df)

                # If destination exists...
                if os.path.exists(dst):

                    # Give the user the option to revise the existing file
                    if os.path.isfile(dst):
                        dst_target = os.path.realpath(dst)
                        print("      >> link '{:s}' already exists,".format(dst))
                        edit = input("         open '{:s}' for revision? (y/n): ".format(dst_target))
                        if edit.lower() == 'y':
                            subprocess.call(['vim', dst_target])

                    # Ask the user whether to override the symbolic link
                    override = input("      >> override existing link '{:s}'? (y/n): ".format(dst))
                    if override.lower() == 'y':
                        if os.path.islink(dst):
                            os.unlink(dst)
                        else:
                            os.remove(dst)
                        # Create link
                        os.symlink(src, dst)

                # Otherwise just create link
                else:
                    os.symlink(src, dst)

        # Ask user whether to init submodules
        subm_init = input(">> Initialize submodules? (y/n): ")
        if subm_init.lower() == 'y':
            subprocess.call(['git', 'submodule', 'update', '--init', '--recursive'])

        # Ask user whether to build Vim's YouCompleteMe (with python3)
        if os.path.exists('./.vim/pack/plugins/start/YouCompleteMe/install.py'):
            install_ycm = input(">> Install Vim's YouCompleteMe? (y/n): ")
            if install_ycm.lower() == 'y':
                # Install YCM
                print("Installing YCM...")
                os.chdir('./.vim/pack/plugins/start/YouCompleteMe/')
                subprocess.call(['./install.py', '--clang-completer'])
                os.chdir(CWD)

    except KeyboardInterrupt:
        print("\nAborting...")
