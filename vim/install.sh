brew install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.config/nvim
ln -s $ZSH/vim/nvimrc.symlink $HOME/.config/nvim/init.vim
nvim +PluginInstall +qall
