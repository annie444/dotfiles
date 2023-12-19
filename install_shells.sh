#!/usr/bin/env bash

install_shell_brew() {
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
}

install_shell_apt() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo apt install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo apt install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo apt install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_apk() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    apk add --no-cache fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo apk add --no-cache zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo apk add --no-cache bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo apk add --no-cache flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_yum() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo yum install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo yum install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo yum install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo yum install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_dnf() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo dnf install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo dnf install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo dnf install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo dnf install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_pacman() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo pacman -Sy fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo pacman -Sy zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo pacman -Sy bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo pacman -Sy flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_emerge() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo emerge sys-apps/fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo emerge sys-apps/zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo emerge sys-apps/bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    echo -e 'sys-apps/flatpak ~amd64\nacct-user/flatpak ~amd64\nacct-group/flatpak ~amd64\ndev-util/ostree ~amd64' | sudo tee -a /etc/portage/package.accept_keywords/flatpak
    sudo emerge sys-apps/flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}

install_shell_zypper() {
  if ! sudo grep -q "$(which fish)" /etc/shells; then
    sudo zypper install fish 
    echo "$(which fish)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which zsh)" /etc/shells; then
    sudo zypper install zsh
    echo "$(which zhs)" | sudo tee -a /etc/shells
  fi

  if ! sudo grep -q "$(which bash)" /etc/shells; then
    sudo zypper install bash 
    echo "$(which bash)" | sudo tee -a /etc/shells
  fi

  if ! command -v flatpak &> /dev/null; then
    sudo zypper install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  fi

  if [[ ! "$SHELL" == "$(which fish)" ]]; then
    chsh -s "$(which fish)"
  fi
}
