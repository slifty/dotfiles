#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Validate required commands
check_command maestral
check_command fileicon

info "Starting Maestral"
maestral start

# Create Maestral directory if it doesn't exist
if [ ! -d ~/Maestral ]; then
	info "Creating Maestral directory"
	mkdir ~/Maestral
	fileicon set ~/Maestral/ /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/LibraryFolderIcon.icns
fi

# Function to replace directory with symlink
replace_with_symlink() {
	local dir_name=$1
	local icon_path=$2
	local local_dir=~/$dir_name
	local maestral_dir=~/Maestral/$dir_name

	# Create the Maestral directory if it doesn't exist
	mkdir -p "$maestral_dir"

	# If local directory exists and is not a symlink, handle it
	if [ -e "$local_dir" ] && [ ! -L "$local_dir" ]; then
		warn "$dir_name exists and will be replaced with a symlink to Maestral"
		info "Backing up existing $dir_name to ${dir_name}.backup"
		mv "$local_dir" "${local_dir}.backup"
	fi

	# Create symlink if it doesn't exist
	if [ ! -L "$local_dir" ]; then
		info "Creating symlink: $local_dir -> $maestral_dir"
		ln -s "$maestral_dir" "$local_dir"
	fi

	# Set icon
	fileicon set "$maestral_dir/" "$icon_path"
	success "$dir_name configured"
}

## We want to use Dropbox versions of a few key directories so they're the same across all devices

# Use sync'd Downloads
replace_with_symlink "Downloads" "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DownloadsFolder.icns"

# Use sync'd Documents
replace_with_symlink "Documents" "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DocumentsFolderIcon.icns"

# Use sync'd Code
replace_with_symlink "Code" "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DeveloperFolderIcon.icns"

# Autostart on load
info "Enabling autostart"
maestral autostart -Y

success "Maestral configuration complete"
