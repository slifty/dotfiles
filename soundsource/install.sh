printf "\e[32mSetting SoundSource  defaults.\e[0m\n"
set -x

# Enable super volume controls
defaults write com.rogueamoeba.soundsource keyboardVolume 1

{ set +x; } 2>/dev/null

echo "\e[32mYou're going to need to give SoundSource accessibility access to support super volume buttons\e[0m\n"
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"

printf "\e[32mSoundsource settings updated.\e[0m\n"
