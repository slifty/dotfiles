#######################
# Rectangle is a tool that supports keyboard commands for resizing windows.
# CLI documentation: https://github.com/rxhanson/Rectangle/blob/master/TerminalCommands.md
#
# To view the plist (e.g. when updating this file)
# plutil -convert xml1 ~/Library/Preferences/com.knollsoft.Rectangle.plist
# edit ~/Library/Preferences/com.knollsoft.Rectangle.plist
printf "\e[32mSetting Rectangle defaults.\e[0m\n"
set -x

#######################
## General Settings
#######################
###
# Launch on login
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
###
# Remove keyboard shortcut restrictions
defaults write com.knollsoft.Rectangle allowAnyShortcut -bool true
###
# Check for updates automatically
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool true
###
# Don't show the welcome message
defaults write com.knollsoft.Rectangle SUHasLaunchedBefore -bool true
###
# Do nothing special if the same command is repeated
# Other options are documented at https://github.com/rxhanson/Rectangle/blob/master/TerminalCommands.md#adjust-behavior-on-repeated-commands
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 2

#######################
## Hotkeys
#######################
###
# Maximize (opt)
# 0
defaults write com.knollsoft.Rectangle leftHalf -dict-add keyCode -float 29 modifierFlags -float 524288
###
# Halves (opt)
# L R
# 1 2
defaults write com.knollsoft.Rectangle leftHalf -dict-add keyCode -float 18 modifierFlags -float 524288
defaults write com.knollsoft.Rectangle rightHalf -dict-add keyCode -float 19 modifierFlags -float 524288
###
# Two-Thirds (opt)
# L R
# 3 4
defaults write com.knollsoft.Rectangle firstTwoThirds -dict-add keyCode -float 20 modifierFlags -float 524288
defaults write com.knollsoft.Rectangle lastTwoThirds -dict-add keyCode -float 21 modifierFlags -float 524288
###
# Quarters (opt)
#   L R
# T q w
# B a s
defaults write com.knollsoft.Rectangle topLeft -dict-add keyCode -float 12 modifierFlags -float 524288
defaults write com.knollsoft.Rectangle topRight -dict-add keyCode -float 13 modifierFlags -float 524288
defaults write com.knollsoft.Rectangle bottomLeft -dict-add keyCode -float 0 modifierFlags -float 524288
defaults write com.knollsoft.Rectangle bottomRight -dict-add keyCode -float 1 modifierFlags -float 524288
###
# Thirds (opt + shift)
# L C R
# z x c
defaults write com.knollsoft.Rectangle firstThird -dict-add keyCode -float 6 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle centerThird -dict-add keyCode -float 7 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle lastThird -dict-add keyCode -float 8 modifierFlags -float 655360
###
# Ninths (opt + shift)
#   L C R
# T 1 2 3
# M q w e
# B a s d
defaults write com.knollsoft.Rectangle topLeftNinth -dict-add keyCode -float 18 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle topCenterNinth -dict-add keyCode -float 19 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle topRightNinth -dict-add keyCode -float 20 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle middleLeftNinth -dict-add keyCode -float 12 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle middleCenterNinth -dict-add keyCode -float 13 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle middleRightNinth -dict-add keyCode -float 14 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle bottomLeftNinth -dict-add keyCode -float 0 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle bottomCenterNinth -dict-add keyCode -float 1 modifierFlags -float 655360
defaults write com.knollsoft.Rectangle bottomRightNinth -dict-add keyCode -float 2 modifierFlags -float 655360

{ set +x; } 2>/dev/null
printf "\e[32mRectangle settings updated.\e[0m\n"
