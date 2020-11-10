echo 'Installing ruby-install ...'

if ! [ -x "$(command -v ruby-install)" ]; then
  wget -O ruby-install-0.7.0.tar.gz \
    https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz
  tar -xzvf ruby-install-0.7.0.tar.gz
  cd ruby-install-0.7.0/
  sudo make install
  cd ..
  rm -rf ruby-install-0.7.0/
  rm ruby-install-0.7.0.tar.gz
else
  echo 'ruby-install already available. Skipping ...'
fi

if ! [ -x "$(command -v chruby)" ]; then
  wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
  tar -xzvf chruby-0.3.9.tar.gz
  cd chruby-0.3.9/
  sudo make install
  cd ..
  rm -rf chruby-0.3.9/
  rm  chruby-0.3.9.tar.gz
else
  echo 'chruby already available. Skipping ...'
fi
