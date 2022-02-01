# Set up SVN
sed -i '' '/^\[groups\]$/a\'$'\n''ots = svn.opentechstrategies.com'$'\n' ~/.subversion/servers
echo '[ots]'$'\n''username = dan' >> ~/.subversion/servers

# Set up the password store
mkdir ~/.password-store
chmod go-rwx ~/.password-store
mkdir ~/.password-store/.extensions
curl https://raw.githubusercontent.com/OpenTechStrategies/pass-git-svn/master/git-svn.bash \
	> ~/.password-store/.extensions/git-svn.bash
chmod a+x ~/.password-store/.extensions/git-svn.bash
pass git-svn clone https://svn.opentechstrategies.com/repos/ots/trunk/.password-store ~/.password-store
