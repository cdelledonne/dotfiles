This repository contains Carlo's dotfiles

## Adding new dotfile

After adding a new dotfile, modify the variable `DOTFILES` in `install.sh` by adding
the new dotfile's name, then commit the changes to `git`.

### Submodules

When adding a submodule to a dotfile, e.g. a plugin to the `.vim` dotfile,
perform the following:

```bash
git submodule add https://url/of/new-plugin.git .vim/pack/plugins/start/new-plugin
```

then commit the changes to `git`.

## Installation

To install the dotfiles, i.e. to symlink them in the proper place, run `install.sh`.

## Extra steps

### Vim's YouCompleteMe

Vim's plugin YouCompleteMe has a built component which has to be taken care of.
After installing the dotfiles with `install.sh`, take the following steps:

- go to YouCompleteMe's folder, add its submodules and then create a
  build directory and a temp directory

```bash
cd .vim/pack/plugins/start/YouCompleteMe
git submodule update --init --recursive
YCM_ROOT=$PWD
mkdir ycm_build
mkdir ycm_temp
```

- download the latest Clang distribution from http://releases.llvm.org/download.html
  and move it into the build directory, then uncompress it

```bash
cd ycm_temp/
mv /path/to/clang+llvm-xxx.tar.xz ./
tar -xJf clang+llvm-xxx.tar.xz
mv clang+llvm-xxx llvm_root_dir
cd ..
```

- build YouCompleteMe and then remove build and temp directories

```bash
cd ycm_build/
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=$YCM_ROOT/ycm_temp/llvm_root_dir . $YCM_ROOT/third_party/ycmd/cpp
cmake --build . --target ycm_core
cd ..
rm -rf ycm_build/ ycm_temp/
```
