#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "InStAlLiNg HoMeBrEw"

  # Install the correct homebrew for each OS type
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  git -C "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core" fetch --unshallow
  git -C "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask" fetch --unshallow
fi

exit 0
