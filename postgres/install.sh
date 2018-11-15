if [ "$(uname -s)" = "Linux" ]
then
  sudo apt-get install -y postgresql 
  echo ""
  echo ""
  ps -ef | grep postgres

  echo ""
  echo " === READ THIS ==="
  echo "Location of config directory should be in the output above"
  echo "Copy the contents of $(pwd)/pg_hba.conf to the config directory for posgres" 
  echo "It sets all local connections to trust, so no password required. You can use the postgres user to connect"
fi
