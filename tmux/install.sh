if [ "$(uname -s)" = "Linux" ]
then
  sudo apt-get install tmux
else
  brew update
  brew install tmux
fi
