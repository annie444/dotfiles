#!/bin/bash

brew install mas

declare -a casks

casks=("1password" "1password-cli" "anki" "arduino-ide" "balenaetcher" "bartender" "breaktimer" "discord" "firefox" "fontforge" "google-chrome" "google-drive" "gpg-suite" "hex-fiend" "inkscape" "logitech-g-hub" "malwarebytes" "messenger" "nextcloud" "pastebot" "pocket-casts" "loopback" "postman" "qbittorrent" "mullvadvpn" "signal" "spotify" "steam" "tor-browser" "transmit" "vlc" "zoom" "libreoffice" "kitty")

function install() {
  c=$1
  echo "Installing $c"
  if brew install --cask $c; then
    echo "Installed $c"
  else
    echo "$c failed to install. Trying again"
    brewFailed=$c
    declare -a masArr
    format=$(echo "$brewFailed" | sed 's/[-_]/ /g')
    masArr+=($(mas search "$format" | grep -wi '$format' | awk 'BEGIN{/([0-9]*)/} { printf "%u ", $1 }'))
    if [ "${#masArr[@]}" -le 3 ]; then
      remove_file $brewFailed
    else
      remove_mas $masArr
    fi
    brew install --cask $brewFailed || echo "$brewFailed failed to install. Please manually intervene."
    echo "Installed $brewFailed"
  fi
}

function remove_mas() {
  masArr=("$@")
  for app in "${masArr[@]}"; do
    echo "Uninstalling app $app"
    if mas uninstall $app; then
      echo "Uninstalled $app"
    else
      appName="$(mas search $app | awk 'match($0, /[0-9]*\s*([0-9A-Za-z ]*)/) { print $2 }')"
      echo "Found $appName"
      file="$(sudo find /Applications -name "*$name*.app" -depth 1)"
      echo "Removing app files at $file"
      sudo rm -rf "$file"
    fi
  done
}

function remove_file() {
  brewFailed=$1
  echo "Removing app $brewFailed"
  appName="$(brew info --cask $brewFailed | grep -A1 'Name' | sed -n 2p)"
  echo "Found $appName"
  file="$(sudo find /Applications -name "*$appName*.app" -depth 1)"
  echo "Removing app files at $file"
  sudo rm -rf "$file"
}

for cask in "${casks[@]}"; do
  install $cask
done 