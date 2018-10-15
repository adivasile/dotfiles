if [ "$(uname -s)" = "Linux" ]
then
  sudo apt-get install tmux
else
  brew update
  brew install tmux
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
