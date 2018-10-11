echo 'Installing RVM ...'
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable
reload!
rvm install ruby-2.5.1
rvm --default use 2.5.1
