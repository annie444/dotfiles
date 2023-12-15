#!/bin/sh

case "$(uname -s)" in
  Darwin)
defaults write NSGlobalDomain com.apple.keyboard.fnState false
defaults write NSGlobalDomain com.apple.mouse.tapBehavior null
defaults write NSGlobalDomain com.apple.sound.beep.feedback 1
defaults write NSGlobalDomain com.apple.sound.beep.volume 1.000
defaults write NSGlobalDomain com.apple.springing.delay 0.5
defaults write NSGlobalDomain com.apple.springing.enabled true
defaults write NSGlobalDomain com.apple.swipescrolldirection true
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick true
defaults write NSGlobalDomain com.apple.trackpad.scaling 2.0
defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior 1
defaults write NSGlobalDomain _HIHideMenuBar false
defaults write NSGlobalDomain AppleEnableMouseSwipeNavigateWithScrolls true
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls true
defaults write NSGlobalDomain AppleFontSmoothing 2
defaults write NSGlobalDomain AppleICUForce24HourTime true
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically true
defaults write NSGlobalDomain AppleKeyboardUIMode 3
defaults write NSGlobalDomain AppleMeasurementUnits Inches
defaults write NSGlobalDomain AppleMetricUnits 0
defaults write NSGlobalDomain ApplePressAndHoldEnabled true
defaults write NSGlobalDomain AppleScrollerPagingBehavior true
defaults write NSGlobalDomain AppleShowAllExtensions true
defaults write NSGlobalDomain AppleShowAllFiles true
defaults write NSGlobalDomain AppleShowScrollBars Automatic
defaults write NSGlobalDomain AppleTemperatureUnit Fahrenheit
defaults write NSGlobalDomain AppleWindowTabbingMode always
defaults write NSGlobalDomain InitialKeyRepeat 15
defaults write NSGlobalDomain KeyRepeat 2
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled true
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled true
defaults write NSGlobalDomain NSDisableAutomaticTermination false
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 true
defaults write NSGlobalDomain NSScrollAnimationEnabled true
defaults write NSGlobalDomain NSTableViewDefaultSizeMode 2
defaults write NSGlobalDomain NSTextShowsControlCharacters false
defaults write NSGlobalDomain NSUseAnimatedFocusRing true
defaults write NSGlobalDomain NSWindowResizeTime 0.2
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 true

defaults write com.apple.screencapture disable-shadow false
defaults write com.apple.screencapture location "{$HOME}/Desktop"
defaults write com.apple.screencapture type "png"


defaults write com.apple.dock appswitcher-all-displays true
defaults write com.apple.dock enable-spring-load-actions-on-all-items true
defaults write com.apple.dock expose-animation-duration 0.5
defaults write com.apple.dock largesize null
defaults write com.apple.dock launchanim true
defaults write com.apple.dock mineffect genie
defaults write com.apple.dock minimize-to-application false
defaults write com.apple.dock orientation bottom
defaults write com.apple.dock show-process-indicators true
defaults write com.apple.dock show-recents true
defaults write com.apple.dock showhidden false
defaults write com.apple.dock autohide false
defaults write com.apple.dock expose-group-by-app false
defaults write com.apple.dock mru-spaces false
defaults write com.apple.dock tilesize 64
defaults write com.apple.dock wvous-bl-corner 1
defaults write com.apple.dock wvous-br-corner 1
defaults write com.apple.dock wvous-tl-corner 5
defaults write com.apple.dock wvous-tr-corner 12


defaults write com.apple.loginwindow GuestEnabled false
defaults write com.apple.loginwindow DisableConsoleAccess true
defaults write com.apple.loginwindow PowerOffDisabledWhileLoggedIn false
defaults write com.apple.loginwindow RestartDisabled false
defaults write com.apple.loginwindow RestartDisabledWhileLoggedIn false
defaults write com.apple.loginwindow SHOWFULLNAME false
defaults write com.apple.loginwindow ShutDownDisabled false
defaults write com.apple.loginwindow ShutDownDisabledWhileLoggedIn false
defaults write com.apple.loginwindow SleepDisabled false


defaults write com.apple.menuextra.clock IsAnalog false
defaults write com.apple.menuextra.clock Show24Hour true
defaults write com.apple.menuextra.clock ShowAMPM false
defaults write com.apple.menuextra.clock ShowDate 0
defaults write com.apple.menuextra.clock ShowDayOfMonth true
defaults write com.apple.menuextra.clock ShowDayOfWeek true
defaults write com.apple.menuextra.clock ShowSeconds false

defaults write com.apple.spaces spans-displays false


defaults write com.apple.AppleMultitouchTrackpad ActuationStrength 1
defaults write com.apple.AppleMultitouchTrackpad Dragging false
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag false
defaults write com.apple.AppleMultitouchTrackpad Clicking true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick true



defaults write com.apple.finder_FXShowPosixPathInTitle false
defaults write com.apple.finder AppleShowAllExtensions true
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder CreateDesktop true
defaults write com.apple.finder FXPreferredViewStyle "Nlsv"
defaults write com.apple.finder QuitMenuItem false
defaults write com.apple.finder ShowPathbar true
defaults write com.apple.finder ShowStatusBar true
defaults write com.apple.finder FXEnableExtensionChangeWarning true
    ;;

  *)
    echo "unsupported OS"
    exit 1
    ;;
esac
