if test $(command -v nvm)
then
  echo "Setting up nvm (and installing latest stable node)"
  nvm install node
  nvm alias default stable
fi

if test $(which yarn)
then
  echo "Installing global yarn packages"
  yarn global add sequelize-cli
	yarn global add @vue/cli
	yarn global add http-server
	yarn global add ts-node
fi
