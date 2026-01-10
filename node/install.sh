if test $(command -v nvm); then
	echo "Setting up nvm (and installing latest stable node)"
	nvm install --lts
	nvm alias default stable
fi

if test $(which npm); then
	echo "Installing global npm packages"
	npm install -g corepack
	npm install -g http-server
fi
