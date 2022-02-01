/***
 * This sets up SMB auto mounts for MacOS
 * see https://apple.stackexchange.com/a/247885/279523
 * It is assumed this file is ebing run from the parent directory `./macos`

 https://apple.stackexchange.com/questions/325686/how-to-add-startup-program-using-terminal
 */
var fs = require('fs');

function containsLine(filePath, line) {
	const contents = fs.readFileSync(filePath, 'utf8');
	return contents.includes(line);
}

const dotfilesConfigLocation = `${process.env.HOME}/.dotfiles/local/config.json`;
const autoMountScriptLocation = `${process.env.HOME}/.dotfiles/local/autoMount.sh`;
const mountRoot = `${process.env.HOME}/Volumes`;

fs.openSync(autoMountScriptLocation, 'w');
fs.chmodSync(autoMountScriptLocation, '755');

try {
	var config = JSON.parse(fs.readFileSync(dotfilesConfigLocation, 'utf8'));
	var smbNetworkMounts = config.smbNetworkMounts;
	smbNetworkMounts.forEach(networkMount => {
		const mountPath = `${mountRoot}/${networkMount.mountName}`
		const {
			username,
			password,
			serverPath,
		} = networkMount

		if (!fs.existsSync(mountPath)) {
			fs.mkdirSync(mountPath)
		}
		const mountCommand = `mount -t smbfs "//${username}:${password}@${serverPath}" ${mountPath}`
		if(!containsLine(autoMountScriptLocation, mountCommand)) {
			fs.appendFileSync(autoMountScriptLocation, `${mountCommand}\n`);
		}
	})
} catch (e) {
	console.log("Couldn't generate the autoMount script")
	console.log(e)
}
