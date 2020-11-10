if [ "$(uname -s)" = "Linux" ]
then
  sudo apt-get install curl git libpq-dev ripgrep
else
  brew install the_silver_searcher
fi

