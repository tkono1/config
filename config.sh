#!/bin/sh

# Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic spell correction.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

# Reduce transparency(it doesn't work).
#sudo defaults write com.apple.universalaccess reduceTransparency -bool true

## Bluetooth
# Enable AAC codec.
sudo defaults write bluetoothaudiod "Enable AAC codec" bool true

# Improve bluetooth audio quality.
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

## Finder ("killall Finder" required)
# Show Finder status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Disable to generate .DS_Store file.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable warning before empty trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false

## Safari (disable SIP required)
# Show all URL on addres bar of Safari.
#defaults write ~/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist ShowFullURLInSmartSearchField -bool true

# Disable opening file after safe download.
#defaults write ~/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist AutoOpenSafeDownloads -bool false

# Disable auto spell correction.
#defaults write ~/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist WebAutomaticSpellingCorrectionEnabled -bool false
