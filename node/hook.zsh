# Load the right node at all times
#
# This will automatically change the node version to whatever value is in .nvmrc
# of a given directory.  If that version of node is not already downloaded it will
# download it.
load-nvmrc() {
	local node_version="$(nvm version)"
	local nvmrc_path="$(nvm_find_nvmrc)"

	if [ -n "$nvmrc_path" ]; then
		local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

		if [ "$nvmrc_node_version" = "N/A" ]; then
			nvm install
		elif [ "$nvmrc_node_version" != "$node_version" ]; then
			nvm use
		fi
	elif [ "$(nvm version default)" = "N/A" ] && [ -n "$(nvm_alias default 2> /dev/null)" ]; then
		[ -n "$_nvm_default_install_failed" ] && return
		local default_alias="$(nvm_alias default)"
		local current_node="$(nvm version node)"
		local install_args=("$default_alias")
		if [ "$current_node" != "N/A" ]; then
			install_args+=(--reinstall-packages-from="$current_node")
		fi
		echo "nvm default ($default_alias) is not installed; installing it"
		if ! nvm install "${install_args[@]}"; then
			_nvm_default_install_failed=1
			echo "Could not install nvm default ($default_alias); run 'nvm install $default_alias' to retry"
		fi
	elif [ "$node_version" != "$(nvm version default)" ]; then
		echo "Reverting to nvm default version"
		nvm use default
	fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
