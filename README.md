This repository contains cdelledonne's dotfiles.  To install the dotfiles, run
```
$ ./install.sh
```

| Dotfile             | Install location   |
|:--------------------|:-------------------|
| `alacritty/`        | `$CONFDIR`         |
| `fontconfig/`       | `$CONFDIR`         |
| `git/`              | `$CONFDIR`         |
| `gitmux/`           | `$CONFDIR`         |
| `nvim/`             | `$CONFDIR`         |
| `tmux/`             | `$CONFDIR`         |
| `.zshrc`            | `$HOME`            |

At run-time, you can selectively choose which ones to install.

By default, `$CONFDIR` equals `$HOME/.config`.  To change that, run
```
export CONFDIR=/some/other/path
```
before running the script.

### TODO

- [ ] Install base packages (zsh, fzf, ripgrep, vim-plug)
- [ ] For macOS, install more packages (coreutils)
