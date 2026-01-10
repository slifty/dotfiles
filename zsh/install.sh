#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Check if Oh My ZSH is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	info "Installing Oh My ZSH"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	success "Oh My ZSH installed"
else
	info "Oh My ZSH already installed"
fi

# Install Powerline Fonts
info "Installing Powerline Fonts"
TEMP_FONTS_DIR=$(mktemp -d)
git clone https://github.com/powerline/fonts.git --depth=1 "$TEMP_FONTS_DIR"
cd "$TEMP_FONTS_DIR"
./install.sh
cd -
rm -rf "$TEMP_FONTS_DIR"
success "Powerline Fonts installed"

# Set zsh as default shell if it isn't already
CURRENT_SHELL=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')
if [ "$CURRENT_SHELL" != "/bin/zsh" ]; then
	info "Setting zsh as default shell"
	chsh -s /bin/zsh
	success "Default shell changed to zsh"
else
	info "zsh is already the default shell"
fi

success "Zsh configuration complete"
