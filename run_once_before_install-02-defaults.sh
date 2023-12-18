#!/bin/sh

case "$(uname -s)" in
  Darwin)
    sudo defaults write NSGlobalDomain com.apple.keyboard.fnState -bool false
    sudo defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1
    sudo defaults write NSGlobalDomain com.apple.sound.beep.volume -float 1.000
    sudo defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
    sudo defaults write NSGlobalDomain com.apple.springing.enabled -bool true
    sudo defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
    sudo defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
    sudo defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0
    sudo defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
    sudo defaults write NSGlobalDomain _HIHideMenuBar -bool false
    sudo defaults write NSGlobalDomain AppleEnableMouseSwipeNavigateWithScrolls -bool true
    sudo defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
    sudo defaults write NSGlobalDomain AppleFontSmoothing -int 2
    sudo defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
    sudo defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true
    sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    sudo defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
    sudo defaults write NSGlobalDomain AppleMetricUnits -int 0
    sudo defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true
    sudo defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
    sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    sudo defaults write NSGlobalDomain AppleShowAllFiles -bool true
    sudo defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"
    sudo defaults write NSGlobalDomain AppleTemperatureUnit -string "Fahrenheit"
    sudo defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
    sudo defaults write NSGlobalDomain InitialKeyRepeat -int 15
    sudo defaults write NSGlobalDomain KeyRepeat -int 2
    sudo defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true
    sudo defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true
    sudo defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
    sudo defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true
    sudo defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
    sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true
    sudo defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false
    sudo defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool true
    sudo defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    sudo defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    sudo defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true
    sudo defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
    sudo defaults write NSGlobalDomain NSTextShowsControlCharacters -bool false
    sudo defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool true
    sudo defaults write NSGlobalDomain NSWindowResizeTime -float 0.2
    sudo defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    sudo defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    sudo defaults write com.apple.screencapture disable-shadow -bool false
    sudo defaults write com.apple.screencapture location -string "${HOME}/Desktop"
    sudo defaults write com.apple.screencapture type -string "png"
    sudo defaults write com.apple.dock appswitcher-all-displays -bool true
    sudo defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
    sudo defaults write com.apple.dock expose-animation-duration -float 0.5
    sudo defaults write com.apple.dock launchanim -bool true
    sudo defaults write com.apple.dock mineffect -string "genie"
    sudo defaults write com.apple.dock minimize-to-application -bool false
    sudo defaults write com.apple.dock orientation -string "bottom"
    sudo defaults write com.apple.dock show-process-indicators -bool true
    sudo defaults write com.apple.dock show-recents -bool true
    sudo defaults write com.apple.dock showhidden -bool false
    sudo defaults write com.apple.dock autohide -bool false
    sudo defaults write com.apple.dock expose-group-by-app -bool false
    sudo defaults write com.apple.dock mru-spaces -bool false
    sudo defaults write com.apple.dock tilesize -int 64
    sudo defaults write com.apple.dock wvous-bl-corner -int 1
    sudo defaults write com.apple.dock wvous-br-corner -int 1
    sudo defaults write com.apple.dock wvous-tl-corner -int 5
    sudo defaults write com.apple.dock wvous-tr-corner -int 12
    sudo defaults write com.apple.loginwindow GuestEnabled -bool true 
    sudo defaults write com.apple.loginwindow DisableConsoleAccess -bool true
    sudo defaults write com.apple.loginwindow PowerOffDisabledWhileLoggedIn -bool false
    sudo defaults write com.apple.loginwindow RestartDisabled -bool false
    sudo defaults write com.apple.loginwindow RestartDisabledWhileLoggedIn -bool false
    sudo defaults write com.apple.loginwindow SHOWFULLNAME -bool false
    sudo defaults write com.apple.loginwindow ShutDownDisabled -bool false
    sudo defaults write com.apple.loginwindow ShutDownDisabledWhileLoggedIn -bool false
    sudo defaults write com.apple.loginwindow SleepDisabled -bool false
    sudo defaults write com.apple.menuextra.clock IsAnalog -bool false
    sudo defaults write com.apple.menuextra.clock Show24Hour -bool true
    sudo defaults write com.apple.menuextra.clock ShowAMPM -bool false
    sudo defaults write com.apple.menuextra.clock ShowDate -int 0
    sudo defaults write com.apple.menuextra.clock ShowDayOfMonth -bool true
    sudo defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
    sudo defaults write com.apple.menuextra.clock ShowSeconds -bool false
    sudo defaults write com.apple.spaces spans-displays -bool false
    sudo defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 1
    sudo defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
    sudo defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    sudo defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
    sudo defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
    sudo defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    sudo defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
    sudo defaults write com.apple.finder_FXShowPosixPathInTitle -bool false
    sudo defaults write com.apple.finder AppleShowAllExtensions -bool true
    sudo defaults write com.apple.finder AppleShowAllFiles -bool true
    sudo defaults write com.apple.finder CreateDesktop -bool true
    sudo defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    sudo defaults write com.apple.finder QuitMenuItem -bool false
    sudo defaults write com.apple.finder ShowPathbar -bool true
    sudo defaults write com.apple.finder ShowStatusBar -bool true
    sudo defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
    ;;

  *)
    echo -string "unsupported OS"
    exit 1
    ;;
esac
