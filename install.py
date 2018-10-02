#!/usr/local/bin/python3

import os
import subprocess

# Get CWD and HOME
CWD  = os.getcwd()
HOME = os.path.expanduser('~')

# Non-dotfiles
NON_DOTFILES = [
    '.DS_Store',
    '.git',
    '.gitmodules',
    'install.py',
    'README.md'
]

# List of dotfiles
dotfiles = os.listdir()

# Remove non-dotfiles
dotfiles = [d for d in dotfiles if not d in NON_DOTFILES]

# Remove possible Vim swap files
dotfiles = [d for d in dotfiles if not (d.endswith('.swp') or d.endswith('.swo'))]

# Install (symlink) dotfiles
print("Installing dotfiles...")
for df in dotfiles:
    install_df = input(">> Install '{:s}'? (y/n): ".format(df))
    if install_df.lower() == 'y':
        src = os.path.join(CWD, df)
        dst = os.path.join(HOME, df)
        if os.path.exists(dst):
            edit = input("   >> File '{:s}' already exists, open for revision? (y/n): ".format(dst))
            if edit.lower() == 'y':
                subprocess.call(['vim', dst])
            override = input("   >> Override '{:s}'? (y/n): ".format(dst))
            if override.lower() == 'y':
                if os.path.islink(dst):
                    os.unlink(dst)
                else:
                    os.remove(dst)
                os.symlink(src, dst)
        else:
            os.symlink(src, dst)

# Build Vim's YouCompleteMe (with python3)
install_ycm = input(">> Install Vim's YouCompleteMe? (y/n): ")
if install_ycm.lower() == 'y':
    print("Installing YCM...")
    os.chdir('./.vim/pack/plugins/start/YouCompleteMe/')
    subprocess.call(['./install.py', '--clang-completer'])
    os.chdir(CWD)
