#!/usr/bin/env bash

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

if ! sudo grep -q "$(brew --prefix)/bin/fish" /etc/shells; then
  brew install fish
  echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
fi

if ! sudo grep -q "$(brew --prefix)/bin/zsh" /etc/shells; then
  brew install zsh
  echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
fi

if ! sudo grep -q "$(brew --prefix)/bin/bash" /etc/shells; then
  brew install bash
  echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
fi

if ! command -v mas &> /dev/null; then
  brew install mas
fi

softwareupdate --install-rosetta --agree-to-license

if [[ ! "$SHELL" == "$(brew --prefix)/bin/fish" ]]; then
  chsh -s "$(brew --prefix)/bin/fish"
fi
