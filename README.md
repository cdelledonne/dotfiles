This repository contains cdelledonne's dotfiles. To install the dotfiles, run
```sh
./install.sh
```

For more help, run
```sh
./install.sh --help
```

| Dotfile       | Destination |
|:--------------|:------------|
| `alacritty/`  | `$CONFDIR`  |
| `fontconfig/` | `$CONFDIR`  |
| `git/`        | `$CONFDIR`  |
| `gitmux/`     | `$CONFDIR`  |
| `lazygit/`    | `$CONFDIR`  |
| `nvim/`       | `$CONFDIR`  |
| `tmux/`       | `$CONFDIR`  |
| `.zshrc`      | `$HOME`     |

| Plugin     | Destination                            |
|:-----------|:---------------------------------------|
| `vim-plug` | `$DATADIR/nvim/site/autoload/plug.vim` |
| `tpm`      | `$DATADIR/tmux/plugins/tpm`            |

By default, `$CONFDIR` equals `$HOME/.config` and `$DATADIR` equals
`$HOME/.local/share`. You can change them before running the script, e.g.:
```sh
export CONFDIR=/some/conf/path
export DATADIR=/some/data/path
```
