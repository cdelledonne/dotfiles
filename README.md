This repository contains Carlo's dotfiles

## Installation

To install the dotfiles run `install.py`.

## Submodules

When adding a submodule to a dotfile, e.g. a plugin to the `.vim` dotfile,
perform the following:

```
git submodule add https://url/of/new-plugin.git .vim/pack/plugins/start/new-plugin
```

then commit the changes to `git`.

To update submodules run:

```
git submodule update --remote --merge
```

then commit.

To remove submodules run:

```
git submodule deinit .vim/pack/plugins/start/old-plugin
git rm .vim/pack/plugins/start/old-plugin
rm -rf .git/modules/.vim/pack/plugins/start/old-plugin
```

Note that the last `rm` command targets a different path then the other two.
