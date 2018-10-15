if [ "$(uname -s)" = "Linux" ]
then
  sudo apt-get install curl
  sudo apt-get install git
  sudo apt-get install silversearcher-ag
else
  bew install the_silver_searcher
fi

