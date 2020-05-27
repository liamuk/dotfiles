# TODO This appears to break BeardedSpice
# Turn off itunes responding to mediakeys
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
# TODO unclear whether the following does anything
#defaults write com.apple.finder CreateDesktop -bool false
# TODO do I want the following?
#defaults write com.apple.Terminal FocusFollowsMouse -string YES
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
sudo mdutil -a -i off
