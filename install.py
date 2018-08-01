#!/usr/local/bin/python3

import os

# Get CWD and HOME
cwd  = os.getcwd()
home = os.path.expanduser('~')

# List of dotfiles
dotfiles = [
    '.bash_profile',
    '.gitconfig',
    '.gitignore_global',
    '.vim',
    '.vimrc'
]

# Install (symlink) dotfiles
print("Installing dotfiles...")
for df in dotfiles:
    src = os.path.join(cwd, df)
    dst = os.path.join(home, df)
    if os.path.exists(dst):
        override = input("File '" + dst + "' already exists, override? (y/n): ")
        if override == 'y':
            if os.path.islink(dst):
                os.unlink(dst)
            else:
                os.remove(dst)
            os.symlink(src, dst)
    else:
        os.symlink(src, dst)

# Build Vim's YouCompleteMe (with python3)
install_ycm = input("Install Vim's YouCompleteMe? (y/n): ")
if install_ycm == 'y':
    print("Installing YCM...")
    os.chdir('./.vim/pack/plugins/start/YouCompleteMe/')
    import install
    os.chdir(cwd)
