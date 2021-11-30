if test $(command -v nvm)
then
  echo "SeTtInG Up NoDe ViA nVm."
  nvm install node
  nvm alias default stable
fi

if test $(which yarn)
then
  echo "SeTtInG Up GlObAl NoDe PaCkAgEs."
  yarn global add express-generator
  yarn global add sequelize-cli
  yarn global add app-icon
	yarn global add @vue/cli
	yarn global add http-server
fi
