git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir $HOME/.config/nvim
ln -s $ZSH/vim/nvimrc.symlink $HOME/.config/nvim/init.vim 
vim +PluginInstall +qall
