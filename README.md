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

To update submodules run:

```bash
git submodule update --remote --merge
```

then commit.

To remove submodules run:

```bash
git submodule deinit .vim/pack/plugins/start/old-plugin
git rm .vim/pack/plugins/start/old-plugin
rm -rf .git/modules/.vim/pack/plugins/start/old-plugin
```

## Installation

To install the dotfiles run `install.sh`.
