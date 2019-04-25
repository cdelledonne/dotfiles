- do everything in bash script
- install dotfiles as usual
- create links from .vim subfolders to .config/nvim (for now, pythonx, spell and ultisnips)
- curl vim-plug into nvim autoload directory
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
